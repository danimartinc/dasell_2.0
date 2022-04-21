import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:DaSell/maps/blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
   
   const GpsAccessScreen({Key? key}) : super(key: key);
   
   @override
   Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
         child: BlocBuilder<GpsBloc, GpsState>(
           builder: (context, state) {

             return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccessButton();
           },
         )
        //  _AccessButton(),
        //  child: _EnableGpsMessage() 
      ),
   );
   }
}

class _AccessButton extends StatelessWidget {

  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Indicamos al usuario que para usar la aplicación es necesario activar GPS
        const Text( 'Es necesario el GPS para utilizar este app'),
        MaterialButton(
          child: const Text('Solicitar Acceso', style: TextStyle( color: Colors.white )),
          color: Colors.black,
          //Redondeamos los bordes
          shape: const StadiumBorder(),
          elevation: 0,
          //Modificamos el splash
          splashColor: Colors.transparent,
          onPressed: () {
            
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAccess();

          }
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {

  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Text(
      'Debe habilitar el GPS',
      style: TextStyle( fontSize: 25, fontWeight: FontWeight.w300 ),
    );
  }
}