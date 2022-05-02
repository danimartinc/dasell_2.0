import '../../../commons.dart';

class AddProductHeader extends StatelessWidget {

  const AddProductHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Text(
      'Selecciona el tipo de producto que quieres vender',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.grey[700],
        fontFamily: 'Poppins',
        fontSize: 18,
      ),
    );
  }
}