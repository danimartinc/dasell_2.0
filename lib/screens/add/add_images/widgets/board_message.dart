import '../../../../commons.dart';
import 'dart:math' as math;

class BoardMessage extends StatelessWidget {
  const BoardMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Transform.rotate(
              angle: math.pi / 12,
              child: Icon(
                Icons.lightbulb_outline,
                color: Colors.amber,
                size: 35,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kGap30,
                Text(
                  'Consejo',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Intenta subir más imágenes del producto, para que se pueda comprobar su estado, y tener más posibilidades de vender el artículo',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}