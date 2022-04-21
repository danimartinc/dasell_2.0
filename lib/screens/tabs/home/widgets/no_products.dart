import 'package:DaSell/commons.dart';
import 'package:DaSell/data/categories.dart';

class NoProducts extends StatelessWidget {
  final VoidCallback? onAddTap;
  final CategoryItemVo? category;

  const NoProducts({
    Key? key,
    this.onAddTap,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: Column(
        children: [
          kGap300,
          Text('No hay productos publicados', style: kNoProductsTextStyle),
          kGap20,
          if (category == null) Text('Todavía no se ha publicado un producto.'),
          if (category != null)
            Text.rich(
              TextSpan(
                text: 'Todavía no se ha publicado un producto en  ',
                children: [
                  TextSpan(
                    text: category!.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Icon(
                        category!.icon,
                        size: 14,
                      ),
                    ),
                    alignment: PlaceholderAlignment.aboveBaseline,
                    baseline: TextBaseline.alphabetic,
                  )
                ],
              ),
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.3),
            ),
          kGap10,
          Text('¡Sé el primero, y sube algo que quieras vender!'),
          kGap30,
          MaterialButton(
            // minWidth: width - 180,
            child: Text('Subir producto', style: kNoProductsWhiteStyle),
            color: Colors.indigo,
            //Redondeamos los bordes del botón
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: onAddTap,
          ),
        ],
      )),
    );
  }
}
