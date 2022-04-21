import 'dart:io';

import '../../../../commons.dart';

class ControlCameraBtn extends StatelessWidget {

  final VoidCallback takePicture;
  final VoidCallback loadAssets;


  const ControlCameraBtn({Key? key, required this.takePicture, required this.loadAssets}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var list = [];
    File? storedImage;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          kGap90,
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: list.length < 6
                ? takePicture
                : () => showDialog(
                  context: context,
                  builder: (context) {
                                      
                    return AlertDialog(
                      content: Text(' Puedes añadir un máximo de seis imágenes'),
                      actions: [
                        ElevatedButton(
                          child: Text('Aceptar'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                ),
                splashColor: Theme.of(context).primaryColor,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width / 3 - 10,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                      ),
                      kGap10,
                      storedImage == null
                      ? Text(
                        'Cámara',
                        style: TextStyle(fontFamily: 'Poppins'),
                      )
                      : Text(       
                        'Añadir otra imagen',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
            ),
          ),
          kGap15,
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: loadAssets,
              splashColor: Theme.of(context).primaryColor,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.width / 3 - 10,
                //width: MediaQuery.of(context).size.height / 3 - 10,
                color: Theme.of(context).cardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 40,
                      ),
                      kGap10,
                      Text(
                        'Galería',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            )
          ),
        ],
      ),
    );
  }
}