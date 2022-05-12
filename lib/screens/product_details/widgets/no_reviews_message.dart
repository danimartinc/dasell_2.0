import '../../../commons.dart';

class NoReviewsMessage extends StatelessWidget {

  const NoReviewsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nadie ha opinado todavía',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18)  
          ),
          kGap20,
          Text( 'Después de una transacción pide que te valoren.',textAlign: TextAlign.center, ),
          Text( 'Las opiniones inspiran confianza.',textAlign: TextAlign.center, ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( FontAwesomeIcons.pencilAlt ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}