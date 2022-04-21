


import 'package:DaSell/maps/widgets/cancel_monitoring_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../commons.dart';
import '../blocs/blocs.dart';

abstract class MonitoringState extends State<CancelMonitoringDialog> {

    LocationBloc? locationBloc;
    
    void cancelMonitoring( int option ) async {

      if( option == 1 ) {   
        // TODO: Disparar dispose, cancelar seguimiento
        locationBloc?.close();
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

    
}