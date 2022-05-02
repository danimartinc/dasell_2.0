import '../../../../commons.dart';

class WantDonateTitle extends StatelessWidget {
  const WantDonateTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Quiero donar este artículo',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 17,
        fontFamily: 'Poppins',
      ),
    );
  }
}