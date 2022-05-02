import 'package:DaSell/commons.dart';

class SortDialog extends StatelessWidget {
  
  final Function(int value)? onSelect;
  const SortDialog({Key? key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Ordenar por',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              onSelect?.call(1);
              Navigator.of(context).pop();
            },
            title: Text(
              'Más cercano',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          ),
          ListTile(
            onTap: () {
              onSelect?.call(2);
              Navigator.of(context).pop();
            },
            title: Text(
              'Más recientes',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
          )
        ],
      ),
    );
  }
}
