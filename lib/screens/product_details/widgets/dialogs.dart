import 'package:DaSell/commons.dart';

class DeleteProductAlert extends StatelessWidget {
  const DeleteProductAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Eliminar esta publicación'),
      content: Text('¿Está seguro de querer eliminar esta publicación?'),
      actions: [
        TextButton(
          child: Text(
            'Salir',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          // onPressed: () => Navigator.of(context).pop(),
          onPressed: context.pop,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
          ),
          child: Text('Confirmar'),
          onPressed: () {
            context.pop(result: true);
            // deleteAd(context);
            // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class SellAlertDialog extends StatelessWidget {
  const SellAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Marcar cómo vendido'),
      content: Text(
          '¿Deseas ocultar este artículo como publicado para el resto de usuarios?'),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: context.pop,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
          ),
          child: Text('Confirmar'),
          onPressed: () {
            context.pop(result: true);
            // markAsSold(context);
          },
        ),
      ],
    );
  }
}
