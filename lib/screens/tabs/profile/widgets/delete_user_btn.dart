import '../../../../commons.dart';

class DeleteUserBtn extends StatelessWidget {

  final VoidCallback onTap;


  const DeleteUserBtn({Key? key, required this.onTap}) : super(key: key);

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
              splashColor: Colors.white10, // Splash color  
              onTap: onTap,
              child: SizedBox(
                width: 56, 
                height: 56, 
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                )
              ),
            ),
          ),
        ),
        kGap5,
        Text('Eliminar cuenta',
          overflow: TextOverflow.ellipsis,)
      ],
    );


    /*return MaterialButton(
      minWidth: width - 180,
      child: Text('Eliminar usuario', style: TextStyle( color: Colors.white ) ),
      color: Colors.indigo,
      //Redondeamos los bordes del botón
      shape: StadiumBorder(),
      elevation: 0,
      splashColor: Colors.transparent,
      onPressed: onPressed
    );*/
  }
}