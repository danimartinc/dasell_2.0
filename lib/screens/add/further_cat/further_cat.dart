import '../../../commons.dart';



//Data
import 'package:DaSell/data/categories.dart';
//Screens
import 'package:DaSell/screens/add/product_info_one/product_info_one.dart';


class FurtherCat extends StatelessWidget {
  
  static const routeName = './further_cat';


  @override
  Widget build(BuildContext context) {

    final index = ModalRoute.of(context)!.settings.arguments as int;
    final cats  = Categories.categories[index];

    //final String icon = 'home';
    //final String? color;

    return Scaffold(
      appBar: AppBar(
        title: Text( cats['category'] ),
        leading: Icon( cats["icon"] ),
      ),
      body: ListView.builder(
        itemCount: cats['further'].length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  //Categories.addCategory(cats['further'][i]);
                  Provider.of<AdProvider>(
                    context,
                    listen: false,
                  ).addCategory( cats['further'][i] );
                  Navigator.of(context).pushReplacementNamed(
                    ProductInfoOne.routeName,
                    //arguments: index,
                    arguments: { 
                      'indexCategory' : index, 
                      'indexFurther'  : i 
                    }
                  );
                },
                title: Text(
                  cats['further'][i],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
               trailing: Icon( Icons.chevron_right_rounded ),
              // leading: Icon( iconMapping[icon], color: HexColor(color) ),
              ),
      
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Divider(),
              ),
            ],
          );
        },
      ),
    );
  }
}
