import '../../../commons.dart';
import 'dart:math' as math;

class IconAuthScreen extends StatelessWidget {
  const IconAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Transform.rotate(
      angle: -math.pi / 18,
      child: Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'DaSell',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Theme.of(context).primaryColor,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}