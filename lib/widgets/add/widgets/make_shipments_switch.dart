import 'package:DaSell/widgets/add/info_form_state.dart';

import '../../../commons.dart';

class MakeShipmentsSwitch extends StatefulWidget {

  const MakeShipmentsSwitch({Key? key}) : super(key: key);

  @override
createState() => _MakeShipmentsSwitchState();
}

class _MakeShipmentsSwitchState extends InfoFormScreenState {
  @override
  Widget build(BuildContext context) {
    
    return SwitchListTile.adaptive(
      title: Text(
                        'Hago envíos',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      subtitle: Text(
                        'Enviar te permite tener opción a vender más artículos. Dispones de servicio de recogida a domicilio',
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                      activeColor: Theme.of(context).primaryColor,
                      value: makeShipments,
                      onChanged: onSwitchShipmentsChanged,
                    );
  }
}