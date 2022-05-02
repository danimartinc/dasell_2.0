import 'package:DaSell/screens/favs/my_ads_state.dart';

import '../../commons.dart';
//Widgets
import '../../services/firebase/models/product_vo.dart';
import '../../widgets/home/ad_item.dart';
import '../tabs/home/widgets/ad_item_widget.dart';
import 'widgets/widgets.dart';


class MyAds extends StatefulWidget {
  
  @override
  createState() => _MyAdsState();
}

class _MyAdsState extends MyAdsScreenState {

  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('uid', isEqualTo: uid)
          .snapshots(),
      builder: ( context, snapshot ) {

        myProducts = [];

       /*if (isLoading) {
          return CommonProgress();
        }
        
        if (myProducts.isEmpty) {
          return PushAdsBtn(); 
        }*/

        //Comprobamos que si tenemos información
        if ( snapshot.hasData ) {
        
          //Widget con la información  
          var documents = snapshot.data!.docs;

            if( documents.length == 0 ) {
              return PushAdsBtn();
            }

            
        for( QueryDocumentSnapshot<Map<String, dynamic>> element in documents ) {

          Map<String, dynamic> elementData = element.data();

          myProducts.add(
            ResponseProductVo.fromJson( elementData )
          );
        }

            return Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: documents.length,
                itemBuilder: (context, i) {

                  final vo = myProducts[i];
                  vo.tag = 'publicados_${ vo.id }';

                 return AdItemWidget(
                    data: vo,
                    onTap: () => onItemTap(vo),
                    onLikeTap: () => onItemLike(vo),
                );

                  //TODO: Widget viejo
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
