import 'package:DaSell/commons.dart';

import 'dart:async';

import '../../chat_room/chat_screen.dart';
import 'models.dart';

abstract class UsersChatController extends State<UsersChatScreen> {

  User? get myUser => FirebaseAuth.instance.currentUser!;
  late StreamSubscription chatStreamSub;
  List<ChatViewItemVo> dataItems = [];

  final _service = FirebaseService.get();

  @override
  void initState() {
    //TODO: CON ESTE MÉTODO RETORNA CADA VEZ QUE ENVÍAS UN MENSAJE, PERO LISTA LOS CHATS
    chatStreamSub = _service.subscribeToMyChats(onChatDataChange);
    //TODO: NO LISTA NINGÚN CHAT, NO SE SI HACE RELOAD
    //chatStreamSub = _service.subscribeToChats(onChatDataChange);
    super.initState();
  }

  @override
  void dispose() {
    chatStreamSub.cancel();
    super.dispose();
  }

  Future<void> onChatDataChange(
    QuerySnapshot<Map<String, dynamic>> event,
  ) async {
    final chatRooms = event.docs.map((e) => ChatRoomVo.fromJson(e.data())).toList();
    dataItems = await _service.getUserChats(chatRooms);
    update();
  }

  /// Item on tap.
  Future<void> onItemTap(ChatViewItemVo item) async {
    await context.push(ChatRoomScreen(user: item.receiver));
  }
}
