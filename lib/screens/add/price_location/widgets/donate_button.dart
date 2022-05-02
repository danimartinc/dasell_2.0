import '../../../../commons.dart';

class DonateButon extends StatelessWidget {

  final VoidCallback onPressed;

  const DonateButon({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var isDonate = false;

    return IconButton(
      icon: isDonate
        ? Icon(
          Icons.favorite,
          color: Colors.red,
          size: 40,
        )
        : Icon(
          Icons.favorite_border,
          color: Colors.red,
          size: 40,
        ),
        onPressed: onPressed                 
    );
  }
}