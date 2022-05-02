import '../../../../commons.dart';
import '../../../../widgets/ui/bottom_button.dart';

class BottomConfirmButton extends StatelessWidget {

  final Function checkInputs;
  
  const BottomConfirmButton({Key? key, required this.checkInputs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomButton(
        'Confirmar',
        () => {
          //  Navigator.of(context).pushNamed(DataBackupHome.routeName),
          checkInputs(context),
        },
        Icons.post_add_outlined,
      );
  }
}