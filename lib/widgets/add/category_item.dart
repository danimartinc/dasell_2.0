import '../../commons.dart';


//Data
import 'package:DaSell/data/categories.dart';
//Screens
import 'package:DaSell/screens/add/further_cat/further_cat.dart';



class CategoryItem extends StatefulWidget {
  
  final int index;

  CategoryItem(
    this.index,
  );

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  
  //final Color color;
  String icon = 'icon';

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context).primaryColor;
    var cats = Categories.categories[widget.index];

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          FurtherCat.routeName,
          arguments: widget.index,
        )
        .then((_) {
          Categories.storedCategories.clear();
        });
        //Categories.addCategory(cats['category']);

         Provider.of<AdProvider>(
          context,
          listen: false,
        ).cleanCategory();
        
        Provider.of<AdProvider>(
          context,
          listen: false,
        ).addCategory(cats['category']);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon( cats["icon"], size: 45, ),
              kGap10,
              Text(
                cats['category'],
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
      
            ]
          ) 
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.40),
              color.withOpacity(0.5),
              color.withOpacity(0.6),
            ], 
            begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Theme.of(context).primaryColor,
          //   width: 1,
          // ),
        ),
      ),
    );
  }
}
