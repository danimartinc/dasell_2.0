import '../../../../commons.dart';

class DeleteReviewDialog extends StatelessWidget {

  final Function(int value)? onSelect;

  const DeleteReviewDialog({Key? key, this.onSelect }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Eliminar opinión'),
      content: Text('¿Está seguro de querer eliminar esta opinión? Se eliminará la opinión seleccionada'),
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