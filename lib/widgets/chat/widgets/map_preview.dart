import 'package:DaSell/commons.dart';
import 'package:DaSell/maps/models/route_destination.dart';
import 'package:DaSell/maps/widgets/btn_cancel_monitoring.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../maps/blocs/location/location_bloc.dart';
import '../../../maps/blocs/search/search_bloc.dart';
import '../../../maps/helpers/widgets_to_marker.dart';
import '../../../maps/widgets/cancel_monitoring_dialog.dart';



class MapPreview extends StatefulWidget {

  final bool isMe;
  final DateTime time;
  final String documentId;
  final bool fullScreen;
  final LatLng? initialLocation;

  //Constructor
  MapPreview({
    required this.isMe,
    required this.time,
    required this.documentId,
    this.fullScreen = false,
    this.initialLocation,
  });

  @override
  State<StatefulWidget> createState() => _MapPreviewState();

}

class _MapPreviewState extends State<MapPreview> {

  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    locationBloc = BlocProvider.of<LocationBloc>(context);
    super.initState();
    _requestPermission();
  }
  
  late ChatRoomVo room;
  LocationBloc? locationBloc;



  @override
  Widget build(BuildContext context) {

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final MoveMap _provider = Provider.of<MoveMap>(context);

    return ChangeNotifierProvider(
      create: (context) => MoveMap(),
      child: Builder(
        builder: (context) {

          return widget.fullScreen
              ? Scaffold(
                  body: FutureBuilder(
                    future: customMarkers(_provider.destination!),
                    builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshotMarker) {
                      if(snapshotMarker.hasData) {
                        return StreamBuilder<DocumentSnapshot>(
                            stream: _firestore
                                .collection('location')
                                .doc(widget.documentId)
                                .snapshots(),
                            builder: (context, snapshot) {

                              if (snapshot.hasData) {
                                print( "final map en =${snapshot.data!['latitude']}, ${snapshot.data!['longitude']}");

                                return dataText2(
                                    CameraPosition(
                                      target: LatLng(
                                        snapshot.data!['latitude'],
                                        snapshot.data!['longitude']
                                      ),
                                      zoom: 16
                                    ),
                                    _provider,
                                    customMarker: snapshotMarker.data
                                );
                              } else {
                                return dataText(
                                  CameraPosition(
                                    target: LatLng(
                                      25.7830661,
                                      -100.3131327
                                    ), //LatLng(40.0,-40.0),
                                    zoom: 15
                                  ),
                                );
                              }
                            });
                      }
                      return Text("Cargando información");
                    },
                  )
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: widget.isMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * (2 / 3),
                        minWidth: MediaQuery.of(context).size.width * (1 / 4),
                        maxHeight: MediaQuery.of(context).size.height * (1 / 4),
                      ),
                      decoration: widget.isMe
                        ? BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.zero,
                            ),
                            color: Theme.of(context).cardColor,
                        )
                        : BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.zero,
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                            ),
                      child: Column(
                        crossAxisAlignment: widget.isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream: _firestore
                                      .collection('markers')
                                      .doc(widget.documentId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {

                                      print( "[${snapshot.data!['latStart']},${snapshot.data!['latStart']}] -> [${snapshot.data!['lngEnd']},${snapshot.data!['lngEnd']}]");
                                      
                                      final searchBloc = BlocProvider.of<SearchBloc>(context);

                                      final LatLng start = LatLng(
                                          snapshot.data!['latStart'],
                                          snapshot.data!['lngStart']);
                                      final LatLng end = LatLng(
                                          snapshot.data!['latEnd'],
                                          snapshot.data!['lngEnd']);
                                      //final destination = await searchBloc.getCoorsStartToEnd(start, end);

                                      return FutureBuilder<RouteDestination>(
                                          future: searchBloc.getCoorsStartToEnd(
                                              start, 
                                              end
                                          ),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              _provider.destination = snapshot.data;
                                              return StreamBuilder<DocumentSnapshot>(
                                                  stream: _firestore
                                                      .collection('location')
                                                      .doc(widget.documentId)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {

                                                      print( "final map en =${snapshot.data!['latitude']}, ${snapshot.data!['longitude']}");

                                                      return dataText2(
                                                        CameraPosition(
                                                          target: LatLng(
                                                            snapshot.data!['latitude'],
                                                            snapshot.data!['longitude']
                                                          ),
                                                          zoom: 16
                                                        ),
                                                       _provider
                                                      );
                                                    } else {
                                                      return dataText(   
                                                        CameraPosition(
                                                          target: LatLng(
                                                            25.7830661,
                                                            -100.3131327),
                                                            //LatLng(40.0,-40.0),
                                                            zoom: 15
                                                        ),
                                                      );
                                                    }
                                                  });
                                            }
                                            return CommonProgress();
                                          });
                                    }
                                    return dataText(CameraPosition(
                                      target: LatLng( 25.7830661, -100.3131327 ),
                                      //LatLng(40.0,-40.0),
                                      zoom: 15)
                                    );
                                  }
                              ),
                            ),
                          ),
                          Container(
                            margin: widget.isMe
                                ? EdgeInsets.fromLTRB(0, 0, 5, 5)
                                : EdgeInsets.fromLTRB(5, 0, 0, 5),
                            child: Text(
                              DateFormat('HH:mm').format(widget.time),
                              style: TextStyle(
                                color: widget.isMe
                                    ? Colors.grey[600]
                                    : Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),

    );
  }

  Widget dataText(CameraPosition position) {

    return Column(
      children: [
        CommonProgress(),
        Text(
          'Obteniendo información',
          textAlign: TextAlign.start,
          style: widget.isMe
              ? Theme.of(context).textTheme.subtitle2!.copyWith(
            fontFamily: 'Poppins',
            fontSize: 14,
          )
          : TextStyle(
            color:
            Theme.of(context).scaffoldBackgroundColor,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget dataText2(CameraPosition position, MoveMap provider, {List<Marker>? customMarker} ) {


    print("Map con pos=${position.target.latitude}, ${position.target.longitude}");
    provider.moveCamera(position.target);
    List<Marker> markers = widget.fullScreen ? [
      Marker(
        anchor: const Offset(0.1, 1),
        markerId: const MarkerId('start'),
        position: position.target,
      ),
      customMarker!.elementAt(0),
      customMarker.elementAt(1)
    ]
    :[
      Marker(
        anchor: const Offset(0.1, 1),
        markerId: const MarkerId('start'),
        position: position.target,
      ),
    ];
    return SizedBox(
      height: widget.fullScreen ? double.infinity : MediaQuery.of(context).size.height * (1 / 5),
      child: Stack(
        children: [
          new GoogleMap(
            initialCameraPosition: position,
            compassEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: widget.fullScreen ? true : false,
            scrollGesturesEnabled: widget.fullScreen ? true : false,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: true,
            polylines: widget.fullScreen ? { provider.drawRoutePolyline() } : const {},
            markers: markers.toSet(),
              onMapCreated: ( controller ) => provider.controller = controller,
              onCameraMove: ( position2 ) => provider.center = position2.target
        
          ),
          if( widget.fullScreen && widget.isMe && (locationBloc?.isSharing ?? false) )
            //CancelMonitoringDialog()
            BtnCancelMonitoring(onPressed: onDialogPressed )
        ] 
      ),
    
    );

  }
    
    void cancelMonitoring( int option ) async {

      if( option == 1 ) {   
        locationBloc?.stopFollowingUser();
        showCancelMonitoringToast(); 
      }
    }

    void onDialogPressed() {
      showDialog(
        context: context,
        builder: (context) => CancelMonitoringDialog(
          onSelect: cancelMonitoring,
        ),
      );
    }


    
  void showCancelMonitoringToast() => Fluttertoast.showToast(
      msg: 'Has dejado de compartir tu ubicación actual',
      fontSize: 15,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
  );



  _requestPermission() async {

    var status = await Permission.location.request();
    
    if (status.isGranted) {
      print('Permisos garantizados');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

Future<List<Marker>> customMarkers(RouteDestination destination) async {

  double kms = destination.distance / 1000;
  kms = (kms * 100).floorToDouble();
  kms /= 100;
  int tripDuration = (destination.duration / 60).floorToDouble().toInt();

  final startMaker = await getStartCustomMarker( tripDuration, 'Mi ubicación' );
  final endMaker = await getEndCustomMarker( kms.toInt(), destination.endPlace.text );

    
  final Marker startMarker = Marker(
    anchor: const Offset(0.1, 1),
    markerId: const MarkerId('start'),
    position: destination.points!.first,
    icon: startMaker,
    // infoWindow: InfoWindow(
    //   title: 'Inicio',
    //   snippet: 'Kms: $kms, duration: $tripDuration',
    // )
  );

  final Marker endMarker = Marker(
    markerId: const MarkerId('end'),
    position: destination.points!.last,
    icon: endMaker,
    // anchor: const Offset(0,0),
    // infoWindow: InfoWindow(
    //   title: destination.endPlace.text,
    //   snippet: destination.endPlace.placeName,
    // )
  );
  return [startMarker, endMarker];
}