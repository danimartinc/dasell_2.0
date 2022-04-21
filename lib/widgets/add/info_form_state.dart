import '../../commons.dart';

import '../../screens/add/add_images/adding_images_screen.dart';
import 'info_form_screen.dart';

abstract class InfoFormScreenState extends State<ProductInfoForm> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String title      = '';
  String desc       = '';
  String prevValue = '';

  Map<String?, String?> sliderValueMap = {
    '0': 'Lo ha dado todo',
    '25': 'En condiciones aceptables',
    '50': 'En buen estado',
    '75': 'Como nuevo',
    '100': 'Nuevo',
  };

  double? sliderValue = 50.0;
  //var textController = TextEditingController();
  var counterText = 0;
  var isLogin = true;
  bool makeShipments = true;

  void trySubmit() {

    final isValidate = formKey.currentState!.validate();
    
    //to remove soft keyboard after submitting
    FocusScope.of(context).unfocus();
    
    if (isValidate) {

      formKey.currentState!.save();

      Provider.of<AdProvider>(
        context,
        listen: false,
      ).addTitleAndStuff(
        title,
        desc,
        sliderValueMap[ sliderValue!.toInt().toString() ],
        makeShipments
      );

      Navigator.of(context).pushReplacementNamed( AddingImagesScreen.routeName );
    }
  }

  Widget counter(
    BuildContext context, {
    int? currentLength,
    int? maxLength,
    required bool isFocused,
  }) {

    return Text(
      '$currentLength / $maxLength',
      style: TextStyle(
        color: Colors.grey,
      ),
      semanticsLabel: 'character count',
    );
  }

  void onSwitchShipmentsChanged( value ) {

    setState(() {
      makeShipments = value;
    });
                      
  }

  String? titleValidator( String? value ) {

    if ( value!.length > 8 ) {
      return null;
    } else {
      return 'El título debe contener más de 8 caracteres';
    }

  }

  String? onDescriptionChanged( String? value ) {

    if ( prevValue.length > value!.length) {
      setState(() {
        counterText--;
      });
    } else {
      setState(() {
        counterText++;
      });
    }
    
    prevValue = value;
    return null;

  }
}