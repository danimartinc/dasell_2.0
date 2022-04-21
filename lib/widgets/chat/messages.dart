//Widgets
import 'package:DaSell/commons.dart';
import 'package:DaSell/widgets/chat/widgets/chat_bubble.dart';
import 'package:DaSell/widgets/chat/widgets/map_preview.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class Messages extends StatelessWidget {
  
  final String documentId;
  final String senderId;
  final String receiverId;

  Messages({
    required this.documentId,
    required this.senderId,
    required this.receiverId,
  });

  /// Utility to get format.
  static final _headerDateFormat = DateFormat('d MMMM, y','es_ES');

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_ES', null);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chats/$documentId/messages')
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CommonProgress();
        }
        var documents = snapshot.data!.docs;
        var lastTime = DateTime.now();
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, i) {
            final data = documents[i];
            final doc = data.data();
            // print("DOC data: $doc");
            final isMe = doc['senderId'] == senderId;
            final time = (doc['timeStamp'] as Timestamp).toDate();

            /// se corre en setState
            /// TODO: CHEQUEA de correr esta LOGICA, 1 sola vez cuando ingresas
            /// en el CHat ROOM
            // if (!isMe && doc['isRead'] == false) {
            //   // print("RUNS TRANSACTION!");
            //   FirebaseFirestore.instance.runTransaction(
            //     (Transaction myTransaction) async => myTransaction.update(
            //       data.reference,
            //       {'isRead': true},
            //     ),
            //   );
            // }

            Widget? dateHeader;

            /// Friday, March 12, 2021
            /// Para probar logica,cambia a:
            // if (lastTime.minute != time.minute) {
            if (lastTime.day != time.day) {
              final headerTitle = _headerDateFormat.format(time,);

              /// render last day.
              dateHeader = Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    headerTitle,
                    // '${lastTime.hour}:${lastTime.minute}:${lastTime.second}',
                  ),
                ),
              );
              
              lastTime = time;
            }

            Widget? displayItem;

            try{
                if (doc['message'] != 'Ubicación') {
                  displayItem = MessageBubble(
                    message: doc['message'],
                    isMe: isMe,
                    time: time,
                    imageUrl: doc['imageUrl'],
                    isRead: doc['isRead'] ?? false,
                  );
                } else {
                  displayItem = InkWell(
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapPreview(
                        isMe: isMe,
                        time: time,
                        documentId: documentId,
                        fullScreen: true,
                      )));
                      
                   
                    },
                    child: AbsorbPointer(
                      child: MapPreview(
                        isMe: isMe,
                        time: time,
                        documentId: documentId,
                      ),
                    ),
                  );
                }
            } catch (e) {
              print(e);
            }
            
            displayItem = Padding(
              padding: EdgeInsets.all(5),
              child: displayItem,
            );

            if (dateHeader != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [dateHeader, displayItem],
              );
            }

            return displayItem;
          },
        );
      },
    );
  }
}
