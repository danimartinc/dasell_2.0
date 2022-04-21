import '../../../commons.dart';

class AdItemFooter extends StatelessWidget {
  
  final dynamic documents;

  const AdItemFooter({Key? key, this.documents }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GridTileBar(
      backgroundColor: Colors.black.withOpacity(0.54),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            documents!['title'],
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
                
          if ( documents!['isSold'] )
                  
          Text( 'Vendido',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
            
          if ( !documents!['isSold'] )

          Text( documents!['price'] == 0
            ? 'Donación'
            : '${documents!['price'].toString()} €',
             textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: documents!['price'] == 0
                ? Colors.pink[200]
                : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}