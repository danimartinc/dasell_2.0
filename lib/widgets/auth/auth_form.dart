import 'package:DaSell/commons.dart';



import 'auth_form_state.dart';


class AuthForm extends StatefulWidget {

  final bool isLoading;

  final Function(
    String? userName,
    String? email,
    String? pass,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  AuthForm( this.submitFn, this.isLoading );

  @override
  createState() => _AuthFormState();
}

class _AuthFormState extends AuthFormScreenState {  

  @override
  Widget build(BuildContext context) {

    //Compruebo que el String que recibo cumple el patrón de un email
    String? pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    //Expresión regular
    RegExp regExp = new RegExp( pattern );


    return Center(
      child: Card(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //EmailFormField(),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: ( value ) {
                      if ( regExp.hasMatch( value! ) ) {
                        return null;
                      } else {
                        return 'Correo electrónico inválido';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: ( newValue ) {
                      email = newValue;
                    },
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      onChanged: (value) {
                        if (prevValue.length > value.length) {
                          setState(() {
                            counterText--;
                          });
                        } else {
                          setState(() {
                            counterText++;
                          });
                        }
                        prevValue = value;
                      },
                      validator: ( value ) {
                        if ( value!.length > 3 ) {
                          return null;
                        } else {
                          return 'El nombre de usuario debe contener al menos 4 caracteres';
                        }
                      },
                      decoration: InputDecoration(
                        counterText: '$counterText/20',
                        labelText: 'Nombre de usuario',
                      ),
                      onSaved: ( newValue ) {
                        userName = newValue;
                      },
                      maxLength: 20,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: ( value ) {
                      if ( value!.length > 7) {
                        return null;
                      } else {
                        return 'La contraseña debe contener al menos 8 caracteres';
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye_outlined),
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                      ),
                    ),
                    obscureText: hidePass,
                    onSaved: ( newValue ) {
                      password = newValue!;
                    },
                  ),
                  kGap20,
              
                  if (widget.isLoading)
                  CommonProgress(),
                  
                  if (!widget.isLoading)
                  //LoginSignButton(onPressed: trySubmit, ),
                  ElevatedButton(
                    child: isLogin ? Text('Iniciar sesión') : Text('Registrarse'),
                    onPressed: trySubmit,
                  ),

                 
                  //AuthButton(onPressed: authChangeisLogin, ),
                  ElevatedButton(
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
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });

                      }   
                  ),               
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
