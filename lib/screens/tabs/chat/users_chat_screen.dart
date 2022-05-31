import 'package:DaSell/commons.dart';
import 'package:DaSell/screens/tabs/chat/no_open_chats.dart';

import 'models.dart';
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: service.streamSubscribeToChats(),
        builder: ( context, __ ){
          if(__.hasData) {
            return FutureBuilder<List<ChatViewItemVo>>(
              future: onChatDataChangeFirst(__.data!),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return snapshot.data!.isEmpty ? NoOpenChats() : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        return ChatRoomItem(
                          data: snapshot.data![index],
                          onTap: () => onItemTap(snapshot.data![index]),
                        );
                      }

                  );
                }
                return CommonProgress();
              },
            );
          }
          if(__.hasError) {
            print(__.error.toString());
            print(__.stackTrace.toString());
          }
          return CommonProgress();
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