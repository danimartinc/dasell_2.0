import '../../../commons.dart';


class PushAdsBtn extends StatelessWidget {
  
  const PushAdsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No tienes publicado ningún producto',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18)  ),
            kGap20,
            Text('Créenos, es muuucho mejor cuando vendes cosas.'),
            Text('¡Sube algo que quieras vender!'),
            kGap30,
            MaterialButton(
              minWidth: width - 180,
              child: Text('Subir producto', style: TextStyle( color: Colors.white ) ),
              color: Colors.indigo,
              //Redondeamos los bordes del botón
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                Provider.of<MenuProvider>(context, listen: false ).setIndex( 2 );
              }
            ),
        ],
      ), 
    );
  }
}