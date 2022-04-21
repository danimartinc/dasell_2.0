import '../../../commons.dart';

class TitleFormField extends StatelessWidget {

  //final VoidCallback validator;

  const TitleFormField({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String title      = '';

    return TextFormField(
      key: ValueKey('title'),
      validator: (value) {
        
        if ( value!.length > 8 ) {
          return null;
        } else {
          return 'El título debe contener más de 8 caracteres';
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Título',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      onSaved: (newValue) {
        title = newValue!;
      },
    );
  }
}