import '../../../../commons.dart';

class SignOutDialog extends StatelessWidget {

  final Function(int value)? onSelect;

  const SignOutDialog({Key? key, this.onSelect }) : super(key: key);

  //const SignOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Cerrar sesión'),
      content: Text('¿Está seguro de querer cerrar sesión?'),
      actions: [
        TextButton(
          child: Text(
            'Cerrar',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Confirmar'),
          onPressed: () async {
            onSelect?.call(1);
            //signOut();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}