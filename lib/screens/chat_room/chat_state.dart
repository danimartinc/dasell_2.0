import 'dart:async';

import 'package:DaSell/commons.dart';
import 'package:DaSell/utils/native_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../maps/screens/loading_screen.dart';
import '../../widgets/chat/widgets/bottom_sheet.dart';
import 'chat_screen.dart';

abstract class ChatRoomScreenState extends State<ChatRoomScreen> {

  late UserVo otherUser = widget.user;
  late final _service = FirebaseService.get();
  late StreamSubscription userSubscription;

  UserVo get myUser => _service.myUserVo!;

  String docId = '';

  String get uid => _service.uid;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    userSubscription.cancel();
    super.dispose();
  }

  void onBackTap() {
    context.pop();
  }

  void _loadData() {
    /// TODO: esto podria ser borrado y accedido desde "_service.chatUsersMap"...
    /// asumiendo que el usuario viene de la lista de chatRooms.
    userSubscription = _service.subscribeToUser(otherUser.uid, onUserDataChange);
    docId = _service.getChatDocId(otherUser);
    /// actualizar UNREAD COUNT to 0
    trace("RESET COUNTER!");
    _service.setChatUnreadZero(roomId: docId);
  }

  void onUserDataChange(DocumentSnapshot<Map<String, dynamic>> event) {
    otherUser = UserVo.fromJson(event);
    update();
  }

  Future<void> onAttachTap() async {
    final result = await showModalBottomSheet<ChatAttachment>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (builder) => ChatBottomSheetModal(),
    );
    if (result == ChatAttachment.camera) {
      uploadImage(ImageSource.camera);
    } else if (result == ChatAttachment.gallery) {
      uploadImage(ImageSource.gallery);
    } else if (result == ChatAttachment.location) {
      /// open map ?
      /*context.push(MapLoadingScreen(
        receiverId: otherUser.uid,
      ));*/

      Navigator.of(context).pushReplacementNamed(
        MapLoadingScreen.routeName, 
        arguments: {
          myUser.uid,
          otherUser.uid,
        }
      );
    }
    // ChatAttachment.camera
    //
    // pickImage(
    //   context,
    //   ImageSource.gallery,
    // );
    // Navigator.of(context).pop();
    //
    // context.push(MapLoadingScreen());
    // Navigator.of(context).pushReplacementNamed(
    //     MapLoadingScreen.routeName,
    //     arguments: {
    //       ChatRoomVo()
    //       //senderID,
    //       //receiverID
    //     }
    // );

    //Navigator.of(context).pushReplacementNamed( LoadingScreen.routeName );
  }

  Future<void> uploadImage(ImageSource source) async {
    final image = await NativeUtils.pickImage(source);
    // trace(myUser);
    // trace(otherUser);
    // docId
    // if ( senderID!.compareTo(receiverID!) > 0 ) {
    //   documentID = receiverID + senderID;
    // } else {
    //   documentID = senderID + receiverID;
    // }
    //
    await Provider.of<AdProvider>(context, listen: false).uploadImage(
      image,
      docId,
      myUser.uid,
      otherUser.uid,
    );
  }
}
