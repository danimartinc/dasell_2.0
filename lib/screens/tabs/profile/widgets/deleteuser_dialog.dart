import '../../../../commons.dart';

class DeleteUserDialog extends StatelessWidget {

  final Function(int value)? onSelect;

  const DeleteUserDialog({Key? key, this.onSelect }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Eliminar usuario'),
      content: Text('¿Está seguro de querer eliminar este usuario? Se eliminarán las publicaciones asociadas a este usuario'),
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
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}