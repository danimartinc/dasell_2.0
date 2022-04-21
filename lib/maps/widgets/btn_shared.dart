import 'package:DaSell/maps/widgets/btn_cancel_monitoring.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../commons.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:DaSell/maps/blocs/blocs.dart';


class BtnShared extends StatefulWidget {
  
  const BtnShared({Key? key}) : super(key: key);

  @override
  State<BtnShared> createState() => _BtnSharedState();
}


class _BtnSharedState extends State<BtnShared> {

  LocationBloc? locationBloc;
  MapBloc? mapBloc;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only( bottom: 10 ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon( Icons.share_location, color: Colors.black ),
          onPressed: () async {

            if( mapBloc!.plannedRoute == true ){

            print("click on btn_shared");
            locationBloc?.startSharing();
            final ts = Timestamp.now();

            String documentId = "";

            if (locationBloc!.sender.compareTo( locationBloc!.receiver ) > 0) {

              documentId = locationBloc!.receiver + locationBloc!.sender;
            } else {

              documentId = locationBloc!.sender + locationBloc!.receiver;
            }

  //            Future<void> sendMessage(
  //   String message, {
  //   required String docId,
  //   required String senderId,
  //   required String receiverId,
  // }) async {
  //   final ts = Timestamp.now();

  //   final messageData = {
  //     'message': message,
  //     'imageUrl': '',
  //     'senderId': senderId,
  //     'receiverId': receiverId,
  //     'timeStamp': ts,
  //     'isRead': false,
  //   };
  //   await firestore
  //       .collection('chats')
  //       .doc(docId)
  //       .collection('messages')
  //       .add(messageData);
        
  //   final chatData = {
  //     'docId': docId,
  //     'lastMessage': message,
  //     'senderId': senderId,
  //     'timeStamp': ts,
  //     'lastModification': FieldValue.serverTimestamp(),
  //     'users': [senderId, receiverId]
  //   };

  //   await firestore.collection('chats').doc(docId).set(chatData);
  // }

            FirebaseService.get().sendMessage(
                'Ubicación',
                docId: documentId,
                senderId: locationBloc!.sender,
                receiverId: locationBloc!.receiver
            );

            await FirebaseFirestore.instance
                .collection('markers')
                .doc(documentId)
                .set({
                  "latStart" : mapBloc?.state.markers["start"]!.position.latitude,
                  "lngStart" : mapBloc?.state.markers["start"]!.position.longitude,
                  "latEnd"   : mapBloc?.state.markers["end"]!.position.latitude,
                  "lngEnd"   : mapBloc?.state.markers["end"]!.position.longitude,
                }, SetOptions(merge: true));
            
            showSharedToast();
            
            }else{
              showErrorSharedToast();
            }
          }
        ),
      ),
    );
  }


  void showSharedToast() => Fluttertoast.showToast(
    msg: 'Ubicación compartida',
    fontSize: 15,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
  );

  
  void showErrorSharedToast() => Fluttertoast.showToast(
    msg: 'Advertencia: Es obligatorio asignar un destino antes de compartir la ubicación',
    fontSize: 15,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red.shade800,
    textColor: Colors.white,
  );

  
}