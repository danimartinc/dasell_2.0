import '../../commons.dart';


//Widgets
import '../../widgets/auth/auth_form.dart';
import 'auth_state.dart';
import 'widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  
  @override
  createState() => _AuthScreenState();
}

class _AuthScreenState extends AuthState {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconAuthScreen(),
              kGap40,
              AuthForm(
                submitFunction,
                isLoading,
              ),
              kGap20,
              GoogleSignInButton(onPressed: signInWithGoogle, ),
              //SignInButton( Buttons.Google, text: 'Iniciar sesión con Google', onPressed: signInWithGoogle ),
            ],
          ),
        ),
      ),
    );
  }
}
