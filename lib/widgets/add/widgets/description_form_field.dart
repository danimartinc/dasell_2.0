import '../../../commons.dart';

class DescriptionFormField extends StatelessWidget {

  final Function(String?) onChanged;

  const DescriptionFormField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var counterText = 0;
    String desc     = '';

    return TextFormField(
      key: ValueKey('desc'),
      onChanged: onChanged,
      validator: (value) {

        if (value!.length > 15) {
          return null;
        } else {
          return 'La descripción debe contener al menos 20 caracteres';
        }
      },
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        counterText: '$counterText/600',
        labelText: 'Descripción',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      onSaved: (newValue) {
        desc = newValue!;
      },
      maxLength: 600,
    );
  }
}


  Widget counter(
    BuildContext context, {
    int? currentLength,
    int? maxLength,
    required bool isFocused,
  }) {

    return Text(
      '$currentLength / $maxLength',
      style: TextStyle(
        color: Colors.grey,
      ),
      semanticsLabel: 'character count',
    );
  }