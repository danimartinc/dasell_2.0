import '../../commons.dart';


import 'package:animate_do/animate_do.dart';


class BtnCancelMonitoring extends StatelessWidget {

  final VoidCallback onPressed;

  const BtnCancelMonitoring({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final mapBloc = BlocProvider.of<MapBloc>(context);
    //LocationBloc? locationBloc;
    final size = MediaQuery.of(context).size;

 

    // Boton de cancelar seguimiento
    return Positioned(
      bottom: 100,
      left: 65,
      child: FadeInUp(
        duration: const Duration(milliseconds: 300),
        child: MaterialButton(
          minWidth: size.width - 140,
          child: const Text('Cancelar seguimiento',
            style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600)
          ),
          color: Colors.red.shade800,
          elevation: 0,
          height: 50,
          shape: const StadiumBorder(),
          onPressed: onPressed,
          
          
          /*() async {                  
            // TODO: Disparar dispose, cancelar seguimiento
            locationBloc?.close();
            showCancelMonitoringToast();
          },*/
        ),
      ),
    );
    

    /*return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: MaterialButton(
        minWidth: size.width -120,
        child: const Text('Dejar de compartir', style: TextStyle( color: Colors.white, fontWeight: FontWeight.w300 )),
        color: Colors.red,
        elevation: 0,
        height: 50,
        shape: const StadiumBorder(),
        onPressed: () async {
                
          // TODO: Disparar dispose, cancelar seguimiento
          locationBloc?.close();        
        },
      ),
    );*/
  }
  
}
