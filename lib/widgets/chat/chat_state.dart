import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;

import '../../commons.dart';
import '../../screens/chat_room/chat_screen.dart';

abstract class ChatScreenState extends State<ChatRoomScreen> {
  
  TextEditingController messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool show = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void pickImage(
    BuildContext context,
    ImageSource src,
  ) async {
    File? _storedImage;
    File? _pickedImage;

    String? documentID;
    String? senderID;
    String? receiverID;

    final picker = new ImagePicker();

    final XFile? pickedImageFile = await picker.pickImage(
      source: src,
      imageQuality: 100,
      maxWidth: 600,
    );

    if (pickedImageFile == null) {
      return;
    }

    _storedImage = File(pickedImageFile.path);

    //Parte importante
    final appDir = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    _pickedImage = savedImage;

    if (senderID!.compareTo(receiverID!) > 0) {
      documentID = receiverID + senderID;
    } else {
      documentID = senderID + receiverID;
    }

    await Provider.of<AdProvider>(context, listen: false).uploadImage(
      _pickedImage,
      documentID,
      senderID,
      receiverID,
    );
  }

  void sendMessage(
    String documentID,
    String senderID,
    String receiverID,
  ) async {
    //FocusScope.of(context).unfocus();
    final ts = Timestamp.now();
    TextEditingController messageController = TextEditingController();
    var enteredMessage = '';

    messageController.clear();

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(documentID)
        .collection('messages')
        .add({
      'message': enteredMessage,
      'imageUrl': '',
      'senderId': senderID,
      'receiverId': receiverID,
      'timeStamp': ts,
      'isRead': false,
    });

    await FirebaseFirestore.instance.collection('chats').doc(documentID).set(
      {
        'docId': documentID,
        'lastMessage': enteredMessage,
        'senderId': senderID,
        'timeStamp': ts,
        'isRead': false,
      },
    );

    setState(() {
      enteredMessage = '';
    });
  }

  void pickImageCamera(context) {
    Navigator.of(context).pop();
  }
}
