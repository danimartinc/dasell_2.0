import '../../../commons.dart';

class NextScreenButton extends StatelessWidget {

  final VoidCallback onPressed;

  const NextScreenButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),  
        //shape: StadiumBorder(),
        child: Container(
          width: 60,
          height: 55,
          child: Center(
            child: Text('Siguiente',),
            //child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 )),
          ),
        ),
        // Icons.arrow_forward, 
        onPressed: onPressed,
      ),
    );
  }
}


    /* BottomButton(
          'Siguiente',
          trySubmit,
          Icons.arrow_forward,
        ),*/