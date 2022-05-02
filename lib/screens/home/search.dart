import '../../commons.dart';

//Widgets
import 'package:DaSell/screens/tabs/home/widgets/ad_item_widget.dart';
import 'package:DaSell/services/firebase/models/product_vo.dart';



class Search extends SearchDelegate {
  
  final List<ResponseProductVo> data;
  final ValueChanged<ResponseProductVo> onItemTap;
  final ValueChanged<ResponseProductVo> onItemLike;
  //Constructor
  Search({
    required this.data,
    required this.onItemTap,
    required this.onItemLike,
  }) : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            this.query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var _query = query.trim();
    var products = List.of(data);
    if (_query.contains('donate:')) {
      _query = _query.replaceAll('donate:', '');
      products = products.where((e) => e.isDonation()).toList();
    }
    if (_query.isNotEmpty) {
      products = products.where((e) => e.containsSearch(_query)).toList();
    }
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: products.length,
        itemBuilder: (context, i) {
          final vo = products[i];
          return AdItemWidget(
            data: vo,
            onTap: () => onItemTap(vo),
            onLikeTap: () => onItemLike(vo),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}
