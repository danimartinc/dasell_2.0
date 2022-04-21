import 'package:DaSell/commons.dart';
import 'package:DaSell/screens/product_details/widgets/widgets.dart';

class ChatBackButton extends StatelessWidget {
  
  final VoidCallback? onTap;
  final String? imageUrl;

  const ChatBackButton({Key? key, this.onTap, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 24),
              Gap(6),
              ProductUserAvatar(
                imageUrl: imageUrl,
                radius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
