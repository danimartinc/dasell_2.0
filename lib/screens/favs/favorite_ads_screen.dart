import 'package:DaSell/screens/favs/my_ads_state.dart';
import 'package:DaSell/services/firebase/models/product_vo.dart';

import '../../commons.dart';

//Widgets
import 'package:DaSell/widgets/home/ad_item.dart';
import '../tabs/home/widgets/ad_item_widget.dart';
import 'widgets/widgets.dart';



class FavoriteAdsScreen extends StatefulWidget {

  static const routeName = './favorite_ads_screen';
  
  @override
  createState() => _FavoriteAdsScreenState();
}

class _FavoriteAdsScreenState extends FavoriteAdsScreenState {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;

  @override
  Widget build( BuildContext context ) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;
 
     
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('isFav', isEqualTo: true )
          .snapshots(),
      builder: ( context, snapshot ) {

        myFavProducts = [];

       /* if (isLoading) {
          return CommonProgress();
        }
        
        if (myFavProducts.isEmpty) {
          return SearchAdsBtn(); 
        }*/


       if ( snapshot.hasData) {
          var documents = snapshot.data!.docs;
        
        if ( documents.length == 0 ) {
          return SearchAdsBtn(); 
        }

        for( QueryDocumentSnapshot<Map<String, dynamic>> element in documents ) {

          Map<String, dynamic> elementData = element.data();

          myFavProducts.add(
            ResponseProductVo.fromJson( elementData )
          );
        }

        return Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: documents.length,
            itemBuilder: (context, i) {

              final vo = myFavProducts[i];
              vo.tag = 'favoritos_${ vo.id }';
              
              return AdItemWidget(
                data: vo,
                onTap: () => onItemTap(vo),
                onLikeTap: () => onItemLike(vo),
              );

              //TODO: Widget anterior
              /*return AdItem(
                  documents[i],
                  documents[i]['uid'] == uid,
                  uid,
              );*/
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          ),
        );
           } else {
          return CommonProgress();
        }  
        
      },
    );
  }
}
