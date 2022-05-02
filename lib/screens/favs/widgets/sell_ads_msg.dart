import '../../../commons.dart';


class SellAdsMsg extends StatelessWidget {
  
  const SellAdsMsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sin ventas finalizadas todavía',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18)  
          ),
            kGap20,
            Text('Si quieres vender algo, simplemente súbelo.'),
            Text('Promociona tus productos o modificalos.'),
            Text('¡Ya verás que bien te sienta!'),
            kGap30,
        ],
      ), 
    );
  }
}