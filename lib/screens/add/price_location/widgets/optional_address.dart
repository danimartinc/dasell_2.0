import '../../../../commons.dart';

class OptionalAddress extends StatelessWidget {

  final TextEditingController addressController;

  const OptionalAddress({Key? key, required this.addressController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 2,
      keyboardType: TextInputType.multiline,
      controller: addressController,
      decoration: InputDecoration(
        labelText: 'Dirección (opcional)',
        labelStyle: TextStyle(
          fontSize: 20, fontFamily: 'Poppins'),
      ),
    );
  }
}