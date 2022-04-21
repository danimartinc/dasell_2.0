// import 'package:DaSell/commons.dart';
//
// class OldChat extends StatefulWidget {
//   const OldChat({Key? key}) : super(key: key);
//   @override
//   _OldChatState createState() => _OldChatState();
// }
//
// class _OldChatState extends State<OldChat> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: FirebaseFirestore.instance
//             .collection('chats')
//             .orderBy('timeStamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var documents = snapshot.data!.docs;
//
//             return ListView.builder(
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 print('${index + 1} times it comes here');
//
//                 docId = documents[index]['docId'].toString();
//
//                 if (docId.contains(uid)) {
//                   receiverId = docId.replaceFirst(uid, '').trim();
//                   print("RID = $receiverId");
//                   print("UID= $uid");
//                   // hI6kO25DBwagNFfByqgOBkr7dME3k95q7onJ6RgnkjwYyMRLBT7PN4Q2
//                   // hI6kO25DBwagNFfByqgOBkr7dME3
//                   return FutureBuilder<DocumentSnapshot>(
//                       future: FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(receiverId)
//                           .get(),
//                       builder: (context, receiverData) {
//                         if (receiverData.connectionState ==
//                             ConnectionState.waiting) {
//                           return Container();
//                         }
//                         if( receiverData.data!=null) {
//                           return Text('Sin usuario!');
//                         }
//                         final reciever = UserVo.fromDoc(receiverData.data!);
//
//                         // snapshot.data?.docs[index].data()['title'],
//                         // print("pero: ${receiverData.data?.data()}");
//                         receiverEmail = receiverData.data!['email'];
//                         receiverName = receiverData.data!['name'];
//                         receiverId = receiverData.data!['uid'];
//                         receiverProfile = receiverData.data!['profilePicture'];
//
//                         //Comprobamos si tenemos información
//                         if (snapshot.hasData) {
//                           //Widget con la información
//                           return Container(
//                             margin: EdgeInsets.symmetric(
//                               vertical: 0,
//                             ),
//                             child: Column(
//                               children: [
//                                 ListTile(
//                                   key: ValueKey(receiverId),
//                                   leading: receiverProfile == ''
//                                       ? Container(
//                                     width: 50,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle),
//                                     child: SvgPicture.asset(
//                                         'assets/images/boy.svg'),
//                                   )
//                                       : CircleAvatar(
//                                     radius: 25,
//                                     backgroundImage:
//                                     NetworkImage(receiverProfile),
//                                   ),
//                                   title: Text(
//                                     receiverName,
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                   subtitle: Text(
//                                     documents[index]['senderId'] == receiverId
//                                         ? documents[index]['lastMessage']
//                                         : 'Tú: ${documents[index]['lastMessage']}',
//                                   ),
//                                   trailing: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         AppUtils.getTimeAgoText(
//                                           (documents[index]['timeStamp']
//                                           as Timestamp)
//                                               .toDate(),
//                                         ),
//                                         style:
//                                         TextStyle(color: Colors.grey[600]),
//                                       ),
//                                       const SizedBox(height: 6),
//                                       // request temporal para conseguir el
//                                       // badge count del query.
//                                       BadgeRequester(
//                                         recieverId: receiverId,
//                                         docId: docId,
//                                         uid: uid,
//                                       ),
//                                     ],
//                                   ),
//                                   // print('receiverName is $receiverName');
//                                   onTap: () {
//                                     onItemTap(receiverData);
//                                   },
//                                 ),
//                                 kDivider5Sep16,
//                               ],
//                             ),
//                           );
//                         } else {
//                           return CommonProgress();
//                         }
//                       });
//                 } else
//                   return kEmptyWidget;
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text(snapshot.error.toString());
//           }
//
//           return CommonProgress();
//         },
//       ),
//     );
//   }
// }
