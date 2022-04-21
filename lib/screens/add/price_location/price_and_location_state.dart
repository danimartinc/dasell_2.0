import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../commons.dart';
import '../../../widgets/loading/data_backup_home.dart';
import '../maps/maps_screen.dart';
import 'price_and_location_screen.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class PriceLocationScreenState extends State<PriceAndLocationScreen> {

  var isDonate     = false;
  var currLocation = '';
  double? latitude;
  double? longitude;
  var containerHeight   = 80.0;
  var textController    = TextEditingController();
  var addressController = TextEditingController();
  var isLoading = false;
  String mapUrl = '';

  Future<void> openMapsScreen() async {

    final location = Location();

    final locData = await location.getLocation();
    latitude = locData.latitude;
    longitude = locData.longitude;

    final locationPreview = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: ( context ) {
          return ProductGoogleMapScreen(
            placeLocation: AdLocation(
              latitude: latitude,
              longitude: longitude,
              address: '',
            ),
            isEditable: true,
          );
        },
      ),
    );

    if (locationPreview == null) {
      return;
    } else {

      print('currentLocation is $locationPreview');

      final loc = locationPreview as LatLng;
      latitude  = loc.latitude;
      longitude = loc.longitude;


      final API_KEY = 'AIzaSyC9oIhVx-R9orUyVXorJSqn_AAfVn0tI9o';
      //var addressUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$API_KEY';

      //Endpoint para realizar el Login
      final uri = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$API_KEY');

      //Mapear la respuesta al modelo de tipo Usuario
      //Petición POST, en la cual enviamos el path del URL por argumento, obtenemos el apiURL desde el Enviroment
      final response = await http.post( uri );

      setState(() {
        mapUrl = Provider.of<AdProvider>(context, listen: false)
          .getLocationFromLatLang(
            latitude: loc.latitude,
            longitude: loc.longitude,
          );

        print('mapUrl is $mapUrl');

        addressController.text = json.decode(response.body)['results'][0]['formatted_address'];
      });
    }
  }

  void checkInputs(BuildContext context ) {

    if ((textController.text.trim() == '0') ||
        (!isDonate && textController.text.isEmpty)) {
          showDialog(
              context: context,
              builder: ( context ) => AlertDialog(
                title: Text('Precio incorrecto'),
                content: Text('Por favor, introduzca un precio válido'),
                actions: [
                  ElevatedButton(
                    child: Text ('Confirmar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
    } else if (mapUrl.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Precio incorrecto'),
          content: Text('Por favor, indique su ubicación para seguir adelante'),
          actions: [
            ElevatedButton(
              child: Text('Proporcione la ubicación'),
              onPressed: () {
                getUserLocation();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    } else {
      submitLocation();
    }
  }

  Future<void> getUserLocation() async {

    final location = Location();

    final locData = await location.getLocation();
    latitude = locData.latitude;
    longitude = locData.longitude;
    
    final API_KEY = 'AIzaSyC9oIhVx-R9orUyVXorJSqn_AAfVn0tI9o';
    // var addressUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$API_KEY';

    //Endpoint para realizar el Login
    final uri = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$API_KEY');

    //Mapear la respuesta al modelo de tipo Usuario
    //Petición POST, en la cual enviamos el path del URL por argumento, obtenemos el apiURL desde el Enviroment
    final response = await http.post( uri );

    setState(() {
      currLocation = '$latitude,$longitude';
      mapUrl = Provider.of<AdProvider>(context, listen: false)
          .getLocationFromLatLang(
            latitude: latitude,
            longitude: longitude,
          );
      
      print('mapUrl is $mapUrl');

      print(json.decode(response.body));

      addressController.text = json.decode(response.body)['results'][0]['formatted_address'];

    });
  }

  Future<void> submitLocation() async {

    if (isDonate) {
      textController.text = '0.0';
    }
    
    Provider.of<AdProvider>(
      context,
      listen: false,
    ).addLocation(
      double.parse(textController.text),
      AdLocation(
        latitude: latitude,
        longitude: longitude,
        address: addressController.text != null ? addressController.text : '',
      ),
    );

    setState(() {
      isLoading = true;
    });

    await Provider.of<AdProvider>(
      context,
      listen: false,
    ).pushToFirebase();
      setState(() {
        isLoading = false;
      });
      
      Navigator.of(context).pushReplacementNamed( DataBackupHome.routeName );
  }

  void onDonatePressed() {

    textController.clear();
    
    FocusScope.of(context).unfocus();
    
    setState(() {
    
      if (isDonate) {
        containerHeight = 80;
      } else {
        containerHeight = 0;
      }
      isDonate = !isDonate;
    });
  }
 }