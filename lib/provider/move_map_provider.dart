import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../maps/models/route_destination.dart';

class MoveMap extends ChangeNotifier {

  GoogleMapController? _mapController;
  LatLng? mapCenter;
  RouteDestination? destination;

  set controller( GoogleMapController c ) => _mapController = c;
  set center( LatLng c ) => mapCenter = c;

  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
  }

  Polyline drawRoutePolyline() {
    
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination?.points ?? [],
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    return myRoute;
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
  
}