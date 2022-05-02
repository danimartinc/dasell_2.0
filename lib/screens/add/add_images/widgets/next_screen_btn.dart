import '../../../../commons.dart';

class NextScreenBtn extends StatelessWidget {

  final VoidCallback onPressed;

  const NextScreenBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(  
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
    );
  }
}



       /* return Button(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: StadiumBorder(),
        onPressed: this.onPressed,
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 )),
          ),
        ),
    );*/