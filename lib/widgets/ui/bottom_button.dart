import 'package:DaSell/commons.dart';

class BottomButton extends StatelessWidget {

  final String title;
  final IconData icon;
  final Function fn;

  //Constructor
  BottomButton(
    this.title, 
    this.fn, 
    this.icon
  );

  @override
  Widget build(BuildContext context) {

      return ElevatedButton(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontFamily: 'Poppins'),
                ),
                kGap15,
                Icon(icon),
              ],
              ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          //Implemento un operador ternario que nos permite crear el botón de manera dinámica
          onPressed: () => fn()
        );

  }
}
