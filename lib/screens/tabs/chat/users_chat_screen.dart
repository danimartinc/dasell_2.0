import 'package:DaSell/commons.dart';

import 'users_chat_controller.dart';
import 'widgets.dart';

class UsersChatScreen extends StatefulWidget {

  static const routeName = '/users_chat_screen';
  
  @override
  createState() => _UsersChatScreenState();
}

class _UsersChatScreenState extends UsersChatController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: kAppbarTitleStyle),
      ),
      body: ListView.builder(
        itemCount: dataItems.length,
        itemBuilder: (context, index) => ChatRoomItem(
          data: dataItems[index],
          onTap: () => onItemTap(dataItems[index]),
        ),
      ),
    );
  }
}
