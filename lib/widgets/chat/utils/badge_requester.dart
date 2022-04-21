import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'badge_count.dart';

class BadgeRequester extends StatefulWidget {

  final String docId, uid, recieverId;

  const BadgeRequester({
    Key? key,
    required this.recieverId,
    required this.docId,
    required this.uid,
  }) : super(key: key);

  @override
  _BadgeRequesterState createState() => _BadgeRequesterState();
}

class _BadgeRequesterState extends State<BadgeRequester> {

  int count = 0;
  //int totalCount = 0;

  @override
  void initState() {
    requestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BadgeCount( count: count );
  }

  Future<void> requestData() async {

    final doc = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.uid + widget.recieverId)
        .get();
        
    final messagesResults = await (
      doc.reference
            .collection('messages')
            .where('receiverId', isEqualTo: widget.uid)
            .where('isRead', isEqualTo: false))
        .get();
    
    /*final totalMessagesResults = await (doc.reference
            .collection('messages')
            .where('receiverId', isEqualTo: widget.uid)
            .where('isRead', isEqualTo: false))
        .get();*/

    if( this.mounted ) {

      setState(() {
        count = messagesResults.size;
        //totalCount = totalMessagesResults.size;
      });
    }


    }

}