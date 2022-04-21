import 'package:DaSell/maps/blocs/blocs.dart';
import 'package:DaSell/maps/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapLoadingScreen extends StatelessWidget {
  static const routeName = './loading_screen';
  //final String receiverId;

  const MapLoadingScreen({
    Key? key,
    //required this.receiverId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Set<String> data = ModalRoute.of(context)!.settings.arguments as Set<String>;
    
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.isAllGranted
              ? MapScreen( args: data )
              : const GpsAccessScreen();
        },
      ),
    );
  }
}
