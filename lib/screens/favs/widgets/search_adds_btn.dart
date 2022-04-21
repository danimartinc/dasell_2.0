import '../../../commons.dart';

class SearchAdsBtn extends StatelessWidget {

  const SearchAdsBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No hay productos añadidos como favoritos',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18)  
          ),
          kGap20,
          Text('Productos que te gustan'),
          Text('Para guardar un producto, pulsa el icono de producto favorito'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( FontAwesomeIcons.heart ),
              ],
            ),
          ),
          kGap30,
          MaterialButton(
            minWidth: width - 180,
            child: Text('Buscar producto', style: TextStyle( color: Colors.white ) ),
            color: Colors.indigo,
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