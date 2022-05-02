import 'package:DaSell/screens/favs/my_ads_state.dart';

import '../../commons.dart';

//Widgets
import '../../services/firebase/models/product_vo.dart';
import '../../widgets/home/ad_item.dart';
import '../tabs/home/widgets/ad_item_widget.dart';
import 'widgets/widgets.dart';



class MySellAds extends StatefulWidget {

   static const routeName = './my_sell_ads_screen';
  
  @override
  createState() => _MySellAdsState();
}

class _MySellAdsState extends MySellAdsScreenState {

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('uid', isEqualTo: uid)
          .where('isSold', isEqualTo: true )
          .snapshots(),
      builder: ( context, snapshot ) {

        mySellProducts = [];

        //Comprobamos que si tenemos información
        if ( snapshot.hasData ) {
        
          //Widget con la información  
          var documents = snapshot.data!.docs;

            if( documents.length == 0 ) {
              return SellAdsMsg();
            }

        for( QueryDocumentSnapshot<Map<String, dynamic>> element in documents ) {

          Map<String, dynamic> elementData = element.data();

          mySellProducts.add(
            ResponseProductVo.fromJson( elementData )
          );
        }

            return Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: documents.length,
                itemBuilder: (context, i) {

                  final vo = mySellProducts[i];

                  vo.tag = 'vendidos_${ vo.id }';

                return AdItemWidget(
                    data: vo,
                    onTap: () => onItemTap(vo),
                    onLikeTap: () => onItemLike(vo),
                );
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