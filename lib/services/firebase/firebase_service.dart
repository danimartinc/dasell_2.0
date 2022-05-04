import 'dart:async';

import 'package:DaSell/commons.dart';
import 'package:DaSell/models/edit_product.dart';

import 'package:DaSell/screens/tabs/chat/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'models/product_vo.dart';

class FirebaseService {
  
  static FirebaseService get() => locator.get();

  late final firestore = FirebaseFirestore.instance;
  late final auth = FirebaseAuth.instance;
  late final fcm = FirebaseMessaging.instance;

  // subscribe my firebase auth user.
  StreamSubscription? _firebaseUserSubscription;

  // subscribe to users doc.
  StreamSubscription? _myUserSubscription;

  Future<void> init() async {
    await Firebase.initializeApp();
    _firebaseUserSubscription =
        auth.authStateChanges().listen(_onFirebaseUserChange);
  }

  void _onFirebaseUserChange(User? event) {
    _myUserSubscription?.cancel();
    _globalChatSubs?.cancel();
    if (event != null) {
      if (hasUser) {
        _myUserSubscription = subscribeToUser(uid, _onMyUserDataChange);
        //// subscribimos al chat global para tener idea de counters.
        listenGlobalChatCounter();
      }
    }
  }

  void _onMyUserDataChange(DocumentSnapshot<Map<String, dynamic>> event) {
    myUserVo = UserVo.fromJson(event);
    chatUsersMap[myUserVo!.uid] = myUserVo!;
  }

  bool get hasUser => auth.currentUser != null;

  bool get hasUserVo => myUserVo != null;

  String get uid => auth.currentUser!.uid;

  // assign this when u login....
  UserVo? myUserVo;

  Future<void> updateUserToken() async {
    var token = await fcm.getToken();
    firestore.collection('users').doc(uid).update({'token': token});
  }

  Future<void> setUserOnline(bool flag) async {
    if (!hasUser) {
      return;
    }
    await firestore.collection('users').doc(uid).update({
      'status': flag ? 'En línea' : "",
    });
  }


  //// get products.
  Future<List<ResponseProductVo>?> getProducts({bool descending = true}) async {
    final res = await firestore
        .collection('products')
        .orderBy('createdAt', descending: descending)
        .get();
    final list = res.docs.toList();
    return list.map((e) => ResponseProductVo.fromJson(e.data())).toList();
  }

  void setLikeProduct(int productId, bool fav) {
    firestore.collection('products').doc('$productId').update({'isFav': fav});
  }

  Future<void> deleteAd(int docId) async {
    await firestore.collection('products').doc('$docId').delete();
  }

  Future<void> markAsSold(int docId) async {
    await firestore
        .collection('products')
        .doc('$docId')
        .update({'isSold': true});
  }

  Future<UserVo> getUser(String userId) async {
    final userData = await firestore.collection('users').doc(userId).get();
    return UserVo.fromJson(userData.data());
  }

  Future<EditProduct> getPostData(String postId) async {
    final postData = await firestore.collection('products').doc(postId).get();
    return EditProduct.fromJson(postData.data()!);
  }

  Future<bool> updatePostData(String postId, Map<String, dynamic> data) async {
    final pos = await firestore.collection('products').doc(postId).update(data);
    return true;
  }

  StreamSubscription subscribeToChats(QueryStreamDataCallback onData) {
    final stream = FirebaseFirestore.instance
        .collection('chats')
        .orderBy('timeStamp', descending: true)
        .snapshots();
    return stream.listen(onData);
  }

  // QueryStreamDataCallback
  StreamSubscription subscribeToMyChats(QueryStreamDataCallback onData) {
    final stream = FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: '$uid')
        .orderBy('timeStamp', descending: true)
        // .withConverter<ChatRoomVo>(
        //   fromFirestore: (e, _) => ChatRoomVo.fromJson(e.data()!),
        //   toFirestore: (data, _) => data.toJson(),
        // )
        .snapshots();
    return stream.listen(onData);
    // return stream
    //     .map(
    //       (event) => event.docs.map((e) => e.data()).toList(),
    //     )
    //     .listen(onData);
  }

  StreamSubscription subscribeToUser(
    String userId,
    DocStreamDataCallback onData,
  ) {
    final stream =
        FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return stream.listen(onData);
  }

  String getChatDocId(UserVo otherUser) {
    if (otherUser.uid.compareTo(uid) > 0) {
      return uid + otherUser.uid;
    } else {
      return otherUser.uid + uid;
    }
  }

  Future<void> sendMessage(
    String message, {
    required String docId,
    required String senderId,
    required String receiverId,
  }) async {
    final ts = Timestamp.now();

    final messageData = {
      'message': message,
      'imageUrl': '',
      'senderId': senderId,
      'receiverId': receiverId,
      'timeStamp': ts,
      'isRead': false,
    };
    await firestore
        .collection('chats')
        .doc(docId)
        .collection('messages')
        .add(messageData);
        
    final chatData = {
      'docId': docId,
      'lastMessage': message,
      'senderId': senderId,
      'timeStamp': ts,
      'lastModification': FieldValue.serverTimestamp(),
      'users': [senderId, receiverId]
    };

    await firestore.collection('chats').doc(docId).set(chatData);
  }

  Map<String, UserVo> chatUsersMap = {};

  Future<void> cacheMissingUsers(List<String> missingUids) async {
    /// make sure we have the data cached.
    final uids = missingUids
        .where(
          (id) => !chatUsersMap.containsKey(id),
        )
        .toList();
    if (uids.isEmpty) {
      trace("All users in cache!");
      return;
    }
    final usersResponse = await firestore
        .collection('users')
        .where('uid', whereIn: uids)
        .withConverter<UserVo>(
            fromFirestore: (snapshot, _) => UserVo.fromJson(snapshot.data()),
            toFirestore: (UserVo value, _) => value.toJson())
        .get();

    /// add into map.
    usersResponse.docs.forEach((snapshot) {
      final userVo = snapshot.data();
      chatUsersMap[userVo.uid] = userVo;
    });
  }

  Future<List<ChatViewItemVo>> getUserChats(List<ChatRoomVo> chatRooms) async {
    var uids = chatRooms.map((e) => e.getOtherUserId(uid)).toList();
    // var chatIds = chatRooms.map((e) => e.docId).toList();
    // trace('-----');
    // trace(chatIds);
    // trace(uid);
    // trace('-----');
    // var a = await firestore
    //     .collection('chats')
    //     .where('docId', whereIn: chatIds).
    //     .where(
    //       FieldPath(['messages', 'isRead']),
    //       isEqualTo: false,
    //     )
    //     .get();
    // trace("A is: ", a.size);

    await cacheMissingUsers(uids);
    final result = <ChatViewItemVo>[];
    for (var room in chatRooms) {

      final otherUserId = room.getOtherUserId(uid);
      final user = chatUsersMap[otherUserId];

      trace( 'otherUser ${ otherUserId }');
      trace( 'user ${ user }' );
      if (user == null) {
        print("Gran problema... el otro usuario no puede no existir");
        return [];
      }

      trace( 'user después de NULL ${ user }' );
      var count = await getChatUnreadCount(roomId: room.docId);
      String subtitle = room.lastMessage ?? '';
      if (room.sentByMe) {
        subtitle = 'Tú: $subtitle';
      }
      final chatRoomItem = ChatViewItemVo(
        unreadCount: count,
        receiver: user,
        title: user.textName,
        subtitle: subtitle,
        time: room.dateTimeStamp,
        imageUrl: user.profilePicture,
      );
      chatRoomItem.roomVo = room;
      result.add(chatRoomItem);
      // dataItems.add(data);
    }
    return result;
  }

  Future<int> getChatUnreadCount({required String roomId}) async {
    final query = await firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .where(
          'isRead',
          isEqualTo: false,
        )
        .where(
          'receiverId',
          isEqualTo: uid,
        )
        .get();
    return query.size;
  }

  /// Podemos usar esto para invalidar el Stream que escucha la lista de chats.
  Future<void> markRoomForUpdate(String roomId) async {
    trace('Entra al update');
    await firestore.collection('chats').doc(roomId).update({
      'lastModification': FieldValue.serverTimestamp(),
    }).then((value) => print("Update LastModification"))
      .catchError((error) => print("Failed to add LastModification: $error"));
    
    trace('Update lastModification');
  }

  Future<void> setChatUnreadZero({required String roomId}) async {
    markRoomForUpdate(roomId);
    final query = await firestore
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .where(
          'isRead',
          isEqualTo: false,
        )
        .where(
          'receiverId',
          isEqualTo: uid,
        )
        .get();

    final batcher = firestore.batch();
    query.docs.forEach((d) {
      batcher.update(d.reference, {'isRead': true});
    });
    batcher.commit();
  }

  final onGlobalRoomCount = ValueNotifier(0);

  void listenGlobalChatCounter() {
    _globalChatSubs?.cancel();
    if (!hasUser) {
      return;
    }
    final stream = firestore
        .collection('chats')
        .where('users', arrayContains: '$uid')
        .snapshots();
    trace("LISTEN to stream...", stream);
    _globalChatSubs = stream.listen(_onGlobalStreamData);
  }

  void _onGlobalStreamData(QuerySnapshot<Map<String,dynamic>> e) async {
    final rooms = e.docs.map((e) => e.data()['docId']).toList();
    var totalCount = 0;
    // Future.wait(rooms.map((r) => getChatUnreadCount(roomId: r))).then((value) {
    //   trace("RESULTADO: $value");
    // });
    // trace("Result list: ", resultList);
    for (var room in rooms) {
      final roomCount = await getChatUnreadCount(roomId: room);
      totalCount += roomCount;
    }
    trace("GLOBAL CHAT COUNTER ",  totalCount);
    onGlobalRoomCount.value = totalCount;
  }

  StreamSubscription? _globalChatSubs;
}

///Shortcurts
typedef DocStreamDataCallback = void Function(
    DocumentSnapshot<Map<String, dynamic>> event);
typedef QueryStreamDataCallback = void Function(
    QuerySnapshot<Map<String, dynamic>> event);
