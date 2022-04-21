import '../../../commons.dart';

class LoginSignButton extends StatelessWidget {

  final VoidCallback onPressed;

  const LoginSignButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var isLogin = true;

    return  ElevatedButton(
      child: isLogin ? Text('Iniciar sesión') : Text('Registrarse'),
      onPressed: onPressed,
    );
  }
}