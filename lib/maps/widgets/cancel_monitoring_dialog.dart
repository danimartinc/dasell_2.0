import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons.dart';
import '../blocs/blocs.dart';
import 'btn_cancel_monitoring.dart';
import 'monitoring_state.dart';

class CancelMonitoringDialog extends StatefulWidget {

  final Function(int value)? onSelect;

  const CancelMonitoringDialog({Key? key, this.onSelect }) : super(key: key);

  @override
  createState() => _CancelMonitoringDialogState();
}

class _CancelMonitoringDialogState extends MonitoringState {
  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text('Ubicación tiempo real'),
      content: Text('¿Está seguro de dejar de compartir la ubicación en tiempo real?'),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: () async {
            locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc?.cancelSharing();
            widget.onSelect?.call(1);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}