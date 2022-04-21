import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as $path;
import 'package:path_provider/path_provider.dart' as $pathProvider;

class NativeUtils {
  // static final _location = Location();
  //
  // static Future<double?> getDistanceFromCoordinates( double? lat, double? long ) async {
  //   final locData = await _location.getLocation();
  //   loc!.latitude  = locData.latitude;
  //   loc!.longitude = locData.longitude;
  //   final distance = Geolocator.distanceBetween(
  //     loc!.latitude!,
  //     loc!.longitude!,
  //     lat!,
  //     long!,
  //   );
  //
  //   return distance;
  // }

  static Future<File?> pickImage(ImageSource src) async {
    // File? _storedImage;
    // File? _pickedImage;
    // String? documentID;
    // String? senderID;
    // String? receiverID;

    final picker = new ImagePicker();

    final XFile? pickedImageFile = await picker.pickImage(
      source: src,
      imageQuality: 100,
      maxWidth: 600,
    );

    if (pickedImageFile == null) {
      return null;
    }

    var _storedImage = File(pickedImageFile.path);

    //Parte importante
    final appDir = await $pathProvider.getApplicationDocumentsDirectory();
    final fileName = $path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    // _pickedImage = savedImage;
    return savedImage;
    //
    // if ( senderID!.compareTo(receiverID!) > 0 ) {
    //   documentID = receiverID + senderID;
    // } else {
    //   documentID = senderID + receiverID;
    // }
    //
    // await Provider.of<AdProvider>(context, listen: false).uploadImage(
    //   _pickedImage,
    //   documentID,
    //   senderID,
    //   receiverID,
    // );
  }
}
