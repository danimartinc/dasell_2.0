
import 'package:DaSell/commons.dart';

class CommonProgress extends StatelessWidget {
  final double strokeWidth;
  const CommonProgress({Key? key, this.strokeWidth=2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(strokeWidth: strokeWidth),
    );
  }
}
