import '../../../commons.dart';
import 'maps_state.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';



class ProductGoogleMapScreen extends StatefulWidget {
  
  final AdLocation? placeLocation;
  final bool isEditable;

  ProductGoogleMapScreen({
    this.placeLocation,
    required this.isEditable,
  });

  @override
  createState() => _ProductGoogleMapScreenState();
}

class _ProductGoogleMapScreenState extends ProductGoogleMapState {

  GoogleMapController? _googleMapController;

    @override
    void dispose() {
      _googleMapController!.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {

    CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(
        widget.placeLocation!.latitude!,
        widget.placeLocation!.longitude!,
      ),
      zoom: 16,
    );


    return Scaffold(
      appBar: AppBar(
        title: widget.isEditable ? Text('Elegir localización') : Text('Ubicación actual'),
        actions: widget.isEditable && pickedLocation != null
          ? [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => Navigator.of(context).pop(pickedLocation),
            ),
          ]
        : [],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
         //Tipo de mapa
        mapType: MapType.normal,
        //Punto que indica la posición actual del usuario
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        buildingsEnabled: true,
        tiltGesturesEnabled: true,
        zoomControlsEnabled: false,
        indoorViewEnabled: true,
        onTap: widget.isEditable ? selectLocation : null,
        markers: getMarker,
        onMapCreated: ( controller ) => _googleMapController = controller,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Position',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () => _googleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}

