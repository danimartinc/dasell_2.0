import '../../../../commons.dart';

class OpenDialogsButton extends StatelessWidget {

  final VoidCallback onTap;

  const OpenDialogsButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;
    var color = Theme.of(context).primaryColor;

      return Column(
        children: [
          ClipOval(
            child: Material(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ), // Button color
              child: InkWell(
                splashColor: Colors.indigo.shade800, // Splash color  
                onTap: onTap,
                child: SizedBox(
                  width: 56, 
                  height: 56, 
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )
                ),
              ),
            ),
          ),
          kGap5,
          Text('Cerrar sesión',
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );


   /* return MaterialButton(
            minWidth: width - 180,
            child: Text('Cerrar sesión', style: TextStyle( color: Colors.white ) ),
            color: Colors.indigo,
            //Redondeamos los bordes del botón
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: onPressed
          );*/
    
    /*return ElevatedButton.icon(
      icon: Icon(
        Icons.logout,
      ),
      onPressed: onPressed,
      label: Text('Cerrar sesión'),
    );*/
  }
}