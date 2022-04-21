import '../../../commons.dart';

class InfoFormHeader extends StatelessWidget {

  const InfoFormHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      'Añade información al producto que quieres publicar',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.grey[700],
        fontFamily: 'Poppins',
        fontSize: 18,
      ),
    );
  }
}