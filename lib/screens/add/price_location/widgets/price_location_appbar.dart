import '../../../../commons.dart';

class PriceLocationAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  const PriceLocationAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      title: Text('Introduzca precio y localización'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
