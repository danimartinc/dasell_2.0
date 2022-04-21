import '../../../commons.dart';


enum ChatAttachment {
  camera,
  gallery,
  location,
}

class ChatBottomSheetModal extends StatelessWidget {
  // final String? senderID;
  // final String? receiverID;

  //Constructor
  const ChatBottomSheetModal({
    Key? key,
    // this.senderID,
    // this.receiverID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconCreation(
                    text: 'Cámara',
                    color: Colors.pink,
                    icon: Icons.camera_alt,
                    onTap: () => context.pop(result: ChatAttachment.camera),
                  ),
                  kGap40,
                  IconCreation(
                    text: 'Galería',
                    icon: Icons.insert_photo,
                    color: Colors.purple,
                    onTap: () => context.pop(result: ChatAttachment.gallery),
                  ),
                  kGap40,
                  IconCreation(
                    text: 'Ubicación',
                    icon: Icons.location_pin,
                    color: Colors.teal,
                    onTap: () => context.pop(result: ChatAttachment.location),
                  ),
                ],
              ),
              kGap30,
            ],
          ),
        ),
      ),
    );
  }
}

class IconCreation extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onTap;

  const IconCreation(
      {Key? key,
      required this.icon,
      required this.color,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          kGap5,
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
