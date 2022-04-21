import 'package:flutter/material.dart';

class MessageSeen extends StatelessWidget {
  
  final bool isRead;

  const MessageSeen({Key? key, this.isRead = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if (isRead) {
      return Icon(
        Icons.done_all,
        color: Colors.blue,
      );
    }

    //Por defecto,se muestra no leido
    return Icon(Icons.done, color: Colors.grey.shade400);
  }
}