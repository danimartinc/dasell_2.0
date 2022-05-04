import '../../commons.dart';
import 'auth_screen.dart';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';



abstract class AuthState extends State<AuthScreen> {

  bool isLoading = false;
  UserCredential? authResult;

  Future<UserCredential?> signInWithGoogle() async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    FirebaseFirestore.instance
        .collection('users')
        .doc( authResult!.user!.uid )
        .set({
          'email': authResult!.user!.email,
          'name': authResult!.user!.displayName,
          'uid': authResult!.user!.uid,
          'profilePicture': authResult!.user!.photoURL,
          'token': '',
          //'reviews': [],
          //'averageReview': 0.0            
        });
    
    return authResult;
  }

  void submitFunction(
    String? userName,
    String? email,
    String? password,
    bool isLogin,
    BuildContext context,
  ) async {
    try {

      setState(() {
        isLoading = true;
      });

      UserCredential authResult;

      if (!isLogin) {

        authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
              'email': email,
              'name': userName,
              'uid': authResult.user!.uid,
              'profilePicture': '',
              'token': '',
              'status': 'Unavalible',
              //'reviews': '',
              //'averageReview': '' 
            });

      } else {

        authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
      }
    } on PlatformException catch (error) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ha ocurrido un error. Por favor, comprueba tus credenciales'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
  
 }