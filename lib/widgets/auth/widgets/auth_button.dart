import '../../../commons.dart';

class AuthButton extends StatelessWidget {

  final VoidCallback onPressed;

  const AuthButton({Key? key, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
     var isLogin = true;

    return  ElevatedButton(
      style:  ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        onPrimary: Colors.white,
        //elevation: 0,
        //tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //shape: RoundedRectangleBorder(
        //borderRadius: BorderRadius.zero,
        //),
      ),
      child: isLogin
        ? Text('Crear cuenta')
        : Text('Ya estoy registrado'),
        onPressed: onPressed,
    );
  }

}