import '../../../commons.dart';
import '../../../data/categories.dart';

class ChangeSubcategory extends StatelessWidget {

  const ChangeSubcategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final data = ModalRoute.of(context)!.settings.arguments as Map<String?, dynamic>;
    final indexCategory = data["indexCategory"];
    final indexFurther  = data["indexFurther"];
  
    final cats  = Categories.categories[indexCategory!];

    return ListTile(
      onTap: () {

        Navigator.of(context).pop(
          AddProduct.routeName
        );

      },
      title: Text('Subcategoría'),
      subtitle: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            kGap30,
            Text(
              cats['further'][indexFurther],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      trailing: Icon( Icons.chevron_right_rounded ),
    );
  }
}