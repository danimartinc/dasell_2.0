import 'dart:io';

import 'package:DaSell/commons.dart';

import '../../add/maps/maps_screen.dart';



class DialogMapScreen extends StatelessWidget {
  final double lat, lon;

  const DialogMapScreen({
    Key? key,
    this.lat = 0.0,
    this.lon = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductGoogleMapScreen(
      placeLocation: AdLocation(
        latitude: lat,
        longitude: lon,
        address: '',
      ),
      isEditable: false,
    );
  }
}

class ProductCategoryButtons extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String>? onCategoryTap;

  const ProductCategoryButtons(
      {Key? key, required this.categories, this.onCategoryTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = categories.map((e) {
      return MaterialButton(
          child: Text(e, style: TextStyle(color: Colors.white)),
          color: Theme.of(context).primaryColor,
          shape: StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            onCategoryTap?.call(e);
          });
    }).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: child,
      ),
    );
  }
}

class ProductUserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const ProductUserAvatar({Key? key, this.radius = 30, this.imageUrl})
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
