import '../../../commons.dart';

class EmailFormField extends StatelessWidget {

  const EmailFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      //Compruebo que el String que recibo cumple el patrón de un email
    String? pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    //Expresión regular
    RegExp regExp = new RegExp( pattern );
    
    String? email = '';

    return TextFormField(
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
    );
  }
}