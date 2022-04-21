import '../../../../commons.dart';

class PriceField extends StatelessWidget {

  final double containerHeight;
  final TextEditingController textController;

  const PriceField({Key? key, required this.containerHeight, required this.textController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: containerHeight,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: textController,
        decoration: InputDecoration(
          suffix: Text(
            '€',
            style: TextStyle(fontSize: 20),
          ),
          labelText: 'Precio',
          labelStyle: TextStyle(
            fontSize: 20, fontFamily: 'Poppins'),
        ),
      ),
    );
  }
}