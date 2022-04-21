import 'package:DaSell/commons.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'DaSell',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Billabong',
        fontSize: 28,
      ),
    );
  }
}
