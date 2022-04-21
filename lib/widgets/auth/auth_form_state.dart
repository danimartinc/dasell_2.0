import '../../commons.dart';
import 'auth_form.dart';



abstract class AuthFormScreenState extends State<AuthForm> {


  final formKey = GlobalKey<FormState>();

  String? userName = '';
  String? email = '';
  String password = '';
  String prevValue = '';
  bool hidePass = true;
  //var textController = TextEditingController();
  var counterText = 0;
  var isLogin = true;

  void trySubmit() {
    
    final isValidate = formKey.currentState!.validate();

    //to remove soft keyboard after submitting
    FocusScope.of( context ).unfocus();
    
    if (isValidate) {
      formKey.currentState!.save();
      widget.submitFn(
        userName!.trim(),
        email!.trim(),
        password.trim(),
        isLogin,
        context,
      );
    }
  }

  Widget counter(
    BuildContext context, {
    int? currentLength,
    int? maxLength,
    required bool isFocused,
  }) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(
        color: Colors.grey,
      ),
      semanticsLabel: 'contador caracteres',
    );
  }

  void authChangeisLogin() {

    setState(() {
      isLogin = !isLogin;
    });
                    
  }

}