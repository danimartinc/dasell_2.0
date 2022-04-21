import '../../../commons.dart';
import 'widgets.dart';


//Widgets
import 'package:DaSell/widgets/add/category_item.dart';
//Data
import 'package:DaSell/data/categories.dart';


class AddProduct extends StatelessWidget {

  static const routeName = './add_product_screen';
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddProductHeader(),
            kGap15,
            Expanded(
              child: GridView.builder(
                itemCount: Categories.categories.length,
                itemBuilder: (context, index ) {
                  return CategoryItem( index );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 340,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
