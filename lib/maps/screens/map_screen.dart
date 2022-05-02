import 'package:DaSell/commons.dart';
import 'package:DaSell/maps/widgets/animated_fab_menu.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:DaSell/maps/blocs/blocs.dart';
import 'package:DaSell/maps/views/views.dart';

import 'package:DaSell/maps/widgets/widgets.dart';

class MapScreen extends StatefulWidget {

  static const routeName = './map_screen.dart';

  final Set<String> args;
  //final String receiverId; 
  const MapScreen({
    Key? key,
    required this.args,
    //required this.receiverId,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  late LocationBloc locationBloc;

  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.sender = widget.args.elementAt(0);
    locationBloc.receiver = widget.args.elementAt(1);
    //locationBloc.sender = FirebaseService.get().uid;
    //locationBloc.receiver = widget.receiverId;
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          
          if (locationState.lastKnownLocation == null) {
           return const Center(child: Text('Espere por favor...'));
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    //if( locationState.lastKnownLocation != null )
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                      markers: mapState.markers.values.toSet(),
                    ),
                    const SearchBar(),
                    const ManualMarker(),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedFabMenu(),
        ],
      ),
    );
  }
}
