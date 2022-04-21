import '../../../commons.dart';
import '../../../data/categories.dart';

class ChangeCategory extends StatelessWidget {

  const ChangeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final data = ModalRoute.of(context)!.settings.arguments as Map<String?, dynamic>;
    final indexCategory = data["indexCategory"];
  
    final cats  = Categories.categories[indexCategory!];
    
    return ListTile(
      onTap: () {
    
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      title: Text('Categoría'),
      subtitle: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon( cats['icon'] ),
            kGap30,
            Text(
              cats['category'],
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      //Text( ''),
      trailing: Icon( Icons.chevron_right_rounded ),
      // leading: Icon( iconMapping[icon], color: HexColor(color) ),
    );
  }
}