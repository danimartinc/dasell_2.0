import 'package:DaSell/commons.dart';
import 'package:DaSell/screens/tabs/chat/no_open_chats.dart';

import 'users_chat_controller.dart';
import 'widgets.dart';

class UsersChatScreen extends StatefulWidget {

  static const routeName = '/users_chat_screen';
  
  @override
  createState() => _UsersChatScreenState();
}

class _UsersChatScreenState extends UsersChatController {

    final _service = FirebaseService.get();

      
    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: kAppbarTitleStyle),
      ),
      body: FutureBuilder(
        //future: onChatDataChangeFirst( dataItems ),
        builder: ( context, __ ){
          
          return dataItems.isEmpty ? NoOpenChats() : ListView.builder(
            itemCount: dataItems.length,
            itemBuilder: (context, index) {

              return ChatRoomItem(
                data: dataItems[index],
                onTap: () => onItemTap(dataItems[index]),
              );
            }

          );
        })



      
     /* dataItems.isEmpty ? SearchAdsBtn() : ListView.builder(
        itemCount: dataItems.length,
        itemBuilder: (context, index) {

       /*   if( dataItems.length == 0 ){
            return SearchAdsBtn();
          }*/


        return ChatRoomItem(
          data: dataItems[index],
          onTap: () => onItemTap(dataItems[index]),
        );
        }
        
        
      ),*/
    );
  }
}
