import 'package:DaSell/screens/favs/my_ads_state.dart';

import '../../commons.dart';
//Widgets
import '../../screens/tabs/home/widgets/ad_item_widget.dart';
import '../../services/firebase/models/product_vo.dart';



class AdsBySeller extends StatefulWidget {
  
  @override
  createState() => _MyAdsState();
}

class _MyAdsState extends AdsBySellerScreenState {

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

        adsBySeller = [];
        
        //Comprobamos que si tenemos información
        if ( snapshot.hasData ) {
        
          //Widget con la información  
          var documents = snapshot.data!.docs;

            if( documents.length == 0 ) {
              return Text('Este vendedor no tiene artículos publicados actualmente');
            }

            
        for( QueryDocumentSnapshot<Map<String, dynamic>> element in documents ) {

          Map<String, dynamic> elementData = element.data();

          adsBySeller.add(
            ResponseProductVo.fromJson( elementData )
          );
        }

            return Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: documents.length,
                itemBuilder: (context, i) {

                  final vo = adsBySeller[i];
                  vo.tag = 'publicaados_${ vo.id }';

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
