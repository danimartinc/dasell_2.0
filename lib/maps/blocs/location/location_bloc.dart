import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  
  StreamSubscription<Position>? positionStream;
  bool isSharing = false;
  String? _sender;
  String? _receiver;
  DateTime? lastUpdate;

  LocationBloc() : super( const LocationState() ) {

    on<OnStartFollowingUser>((event, emit) => emit( state.copyWith( followingUser: true ) ));
    on<OnStopFollowingUser>((event, emit) => emit( state.copyWith( followingUser: false ) ));
    
    on<OnNewUserLocationEvent>((event, emit) {

      emit( 
        state.copyWith(
          lastKnownLocation: event.newLocation,
          myLocationHistory: [ ...state.myLocationHistory, event.newLocation ],
        ) 
      );

    });

  }


  Future getCurrentPosition() async {

    final position = await Geolocator.getCurrentPosition();

    add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude ) ) );
  }

  void startFollowingUser() {
    
    add(OnStartFollowingUser());
    
    positionStream = Geolocator.getPositionStream().listen((event) async {

      final position = event;

      if(isSharing && (lastUpdate==null || (DateTime.now().difference(lastUpdate!).inSeconds) > 2)) {

        print("location_bloc linea 50, Ubicacion: ${position.latitude} ${position.longitude}");
        lastUpdate = DateTime.now();
        
        try {
          await FirebaseFirestore.instance.collection('location').doc(getDoc).set({
            'latitude': position.latitude,
            'longitude': position.longitude
          }, SetOptions(merge: true));

        } catch (e) {
          print(e);
        }
      }
      
      add( OnNewUserLocationEvent( LatLng( position.latitude, position.longitude ) ) );
    });

  }

  void startSharing() {
    isSharing = true;
    print("now we are sharing location");
  }

  void cancelSharing() {
    isSharing = false;
    print("now we are NOT sharing location");
  }

  set sender(String doc) {
    _sender = doc;
  }

  set receiver(String doc) {
    _receiver = doc;
  }

  String get sender => _sender ?? '';

  String get receiver => _receiver ?? '';

  String get getDoc {

    if (sender.compareTo(receiver) > 0) {
      return receiver + sender;
    } else {
      return sender + receiver;
    }
    
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add( OnStopFollowingUser());
    print('stopFollowingUser');
  }


  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }

}
