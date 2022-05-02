
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../commons.dart';

class GoogleSignInButton extends StatelessWidget {

  final VoidCallback onPressed;

  const GoogleSignInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SignInButton( Buttons.Google, text: 'Iniciar sesión con Google', onPressed: onPressed );
  }
}