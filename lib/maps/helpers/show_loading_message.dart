import 'dart:io';

import 'package:DaSell/commons.dart';
import 'package:flutter/cupertino.dart';


void showLoadingMessage( BuildContext context ) {

  // Android
  if ( Platform.isAndroid ) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ( context ) => AlertDialog(
        title: const Text('Espere por favor'),
        content: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only( top: 10),
          child: Column(
            children: const [
              Text('Calculando ruta'),
              kGap15,
              CommonProgress(),
            ],
          ),
        ),
      )
    );
    return;
  }

  showCupertinoDialog(
    context: context, 
    builder: ( context ) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    )
  );


}


