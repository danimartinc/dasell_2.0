import 'package:DaSell/commons.dart';

class ChatAppBarTitle extends StatelessWidget {
  final String name, status;

  const ChatAppBarTitle({
    Key? key,
    required this.name,
    this.status = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (name.isEmpty) {
      return kEmptyWidget;
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
          ),
          Text(
            status,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );

    ///StreamBuilder<DocumentSnapshot>(
    //                   stream: _firestore
    //                       .collection('users')
    //                       .doc(userData.uid)
    //                       .snapshots(),
    //                   builder: (context, snapshot) {
    //                     if (snapshot.data != null) {
    //                       return Container(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               userData.textName,
    //                               style: TextStyle(
    //                                 fontSize: 18.5,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                             Text(
    //                               snapshot.data!['status'],
    //                               style: TextStyle(
    //                                 fontSize: 13,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       );
    //                     } else {
    //                       return Container();
    //                     }
    //                   })
  }
}
