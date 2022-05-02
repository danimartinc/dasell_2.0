import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EmojiSelect extends StatefulWidget {

  EmojiSelect({Key? key}) : super(key: key);

  @override
  State<EmojiSelect> createState() => _EmojiSelectState();
}

class _EmojiSelectState extends State<EmojiSelect> {

  TextEditingController messageController = TextEditingController();

  @override
  Widget build( BuildContext context ) {

    return EmojiPicker(
    config: Config(
      columns: 7,
      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
      verticalSpacing: 0,
      horizontalSpacing: 0,
      initCategory: Category.RECENT,
      bgColor: const Color(0xFFF2F2F2),
      indicatorColor: Colors.blue,
      iconColor: Colors.grey,
      iconColorSelected: Colors.blue,
      progressIndicatorColor: Colors.blue,
      backspaceColor: Colors.blue,
      showRecentsTab: true,
      recentsLimit: 28,
      noRecentsText: 'No Recientes',
      noRecentsStyle: const TextStyle(
        fontSize: 20, color: Colors.black26
      ),
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL
    ),          
    onEmojiSelected: (category, emoji ) {
        
      print(emoji);

      setState(() {
         messageController.text = messageController.text + emoji.emoji;
      });
      }
    );
  }
}
