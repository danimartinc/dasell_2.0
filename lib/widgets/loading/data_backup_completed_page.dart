import 'package:DaSell/commons.dart';
import 'package:DaSell/screens/bottom_navigation.dart';
import 'package:vector_math/vector_math_64.dart' as vector;


class DataBackupCompletedPage extends AnimatedWidget {


  DataBackupCompletedPage( { Animation<double>? endingAnimation } ) : super( listenable: endingAnimation! );

  Animation get animation => ( listenable as Animation );


  @override
  Widget build(BuildContext context) {
    return animation.value > 0 
      ? Positioned.fill(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    foregroundPainter: _DataBackupCompletedPainter( animation ),
                    child: Container(
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox( height: 60, ),
              Expanded(
                child: TweenAnimationBuilder(
                  tween: Tween( begin: 0.0, end: 1.0 ),
                  duration: const Duration( milliseconds: 400, ),
                  builder: ( _ , double? value, child ){
                    
                    return Opacity(
                      opacity: value!,
                      child: Transform.translate(
                        offset: Offset( 
                          0.0, 
                          50 * ( 1 - value ),
                        ),
                        child: child,
                      ),
                    );
                  }, 
                  child: Column(
                    children: [
                      const Text('El artículo se ha publicado correctamente',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      OutlinedButton(
                        child: const Padding(
                          padding: EdgeInsets.symmetric( vertical: 20.0, horizontal: 40.0 ),
                          child: Text('Aceptar', 
                            style: TextStyle( 
                              color: mainDataBackupColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Provider.of<MenuProvider>( context, listen: false ).setIndex( 0 );
                          Navigator.of(context).maybePop();
                        }
                      ),
                      kGap40,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ) : const SizedBox.shrink();
  }
}

class _DataBackupCompletedPainter extends CustomPainter {

  final Animation? animation;

  _DataBackupCompletedPainter( 
    this.animation
  ):super( repaint: animation );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = mainDataBackupColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final circlePath = Path();
    circlePath.addArc(
      Rect.fromCenter(
        center: Offset( size.width / 2, size.height/2 ),
        height: size.height,
        width: size.width
      ), 
      vector.radians( -90.0 ), 
      vector.radians( 360.0 * animation!.value ),
    );

    final leftLine  = size.width * 0.2;
    final rightLine = size.width * 0.3;

    final leftPercent  = animation!.value > 0.5 ? 1.0 : animation!.value / 0.5;
    final rightPercent = animation!.value < 0.5 ? 0.0 : ( animation!.value - 0.5 ) / 0.5;

    canvas.save();

    canvas.translate( size.width / 3, size.height / 2 );
    canvas.rotate( vector.radians(-45) );

    canvas.drawLine(Offset.zero, Offset( 0.0, leftLine * leftPercent ), paint);

    canvas.drawLine(Offset( 0.0, leftLine ), Offset( rightLine * rightPercent, leftLine ), paint);

    canvas.restore();
    
    canvas.drawPath( circlePath, paint );
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}