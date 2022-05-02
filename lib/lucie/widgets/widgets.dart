
import 'dart:io';

import '../../commons.dart';

class ProductUserAvatarDetails extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const ProductUserAvatarDetails({Key? key, this.radius = 30, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if (imageUrl?.isEmpty == true) {
      return Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: SvgPicture.asset('assets/images/boy.svg'),
      );
    }
    final url = imageUrl!;
    if (url.startsWith('http')) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(url),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(url)),
      );
    }
  }
}