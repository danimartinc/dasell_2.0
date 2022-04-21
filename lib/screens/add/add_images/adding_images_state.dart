import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../../../commons.dart';
import '../price_location/price_and_location_screen.dart';
import 'adding_images_screen.dart';


import 'dart:io';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;

abstract class AddingImagesScreenState extends State<AddingImagesScreen> {
      
    bool isCamera = true;
    List<Asset> images = <Asset>[];
    var list = [];
    String? _error;

    
    File? storedImage;
    File? pickedImage;
    List<File> pathList = [];

  Future<void> loadAssets() async {
  
    List<Asset>? resultList;
    String? error;
    
    isCamera = false;
    
    setState(() {
      images = <Asset>[];
    });
    
    
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    
    if (!mounted) return;
    
    if (resultList == null) return;
    
    setState(() {
      images = resultList!;
      list = images;
      if (error == null) _error = 'No se ha detectado el error';
    });
  }
  
  Future<void> takePicture() async {

    isCamera = true;
    
    final picker = new ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
         source: ImageSource.camera, 
         imageQuality: 100, 
         maxWidth: 600
    );
    
    if (pickedFile == null) {
       return;
     }
    
    setState(() {
      storedImage = File(pickedFile.path);
       pathList.add( storedImage!);
       list = pathList;
     });
    
    //Muy importante
    final appDir = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename( storedImage!.path);
    final savedImage = await storedImage!.copy('${appDir.path}/$fileName');
    pickedImage = savedImage;
  }


  void submitImage() {
    
    if (list.isEmpty) {
      
      showDialog(
        context: context,
          //Instrucción
          builder: ( context ) {
            return AlertDialog(
              title: Text('No hay imágenes añadidas'),
              content: Text('Por favor, añada al menos una imagen'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            );
          }
      );
    
      return;
    } else if (isCamera) {
      Provider.of<AdProvider>(context, listen: false).addImagePaths(pathList);
    } else {
      Provider.of<AdProvider>(context, listen: false).addImageAssets(images);
    }

    Navigator.of(context).pushReplacementNamed(PriceAndLocationScreen.routeName);
  }

}