import '../../../commons.dart';

class NoOpenChats extends StatelessWidget {

  const NoOpenChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sin mensajes todavía',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18)  
          ),
          kGap20,
          Text('Chatear con los demás puedeser el comienzo de una transacción.'),
          Text('Encuentra algo que te guste y empieza una conversación.'),

          kGap30,
          MaterialButton(
            minWidth: width - 180,
            child: Text('Buscar en DaSell', style: TextStyle( color: Colors.white ) ),
            color: Theme.of(context).primaryColor,
            //Redondeamos los bordes del botón
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {
              Provider.of<MenuProvider>( context, listen: false ).setIndex(0);
            }
          ),
        ],
      ),
    );
  }
}