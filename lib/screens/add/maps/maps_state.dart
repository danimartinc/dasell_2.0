import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../commons.dart';
import 'maps_screen.dart';

abstract class ProductGoogleMapState extends State<ProductGoogleMapScreen> { 


  LatLng? pickedLocation;

  void selectLocation( LatLng position ) {

    setState(() {
      pickedLocation = position;
    });
  }

  Set<Marker> get getMarker {
    
    if ( pickedLocation == null) {
          return {
            Marker(
              markerId: MarkerId('id'),
              position: LatLng(
                widget.placeLocation!.latitude!,
                widget.placeLocation!.longitude!,
              ),
            )
          };
    } else {
      return {
        Marker(
          markerId: MarkerId('id'),
          position: pickedLocation!,
        )
      };
    }
  }

}