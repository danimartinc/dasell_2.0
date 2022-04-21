import '../../../commons.dart';
import '../../../widgets/add/info_form_screen.dart';


//Widgets



class ProductInfoOne extends StatefulWidget {

  static const routeName = './product_info';
  
  @override
  _ProductInfoOneState createState() => _ProductInfoOneState();
}

class _ProductInfoOneState extends State<ProductInfoOne> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Detalles del producto'),
      ),
      body: ProductInfoForm(),
      // bottomNavigationBar: BottomButton(
      //   'Next',
      //   () {},
      //   Icons.arrow_forward,
      // ),
    );
  }
}
