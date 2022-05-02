import 'package:DaSell/lucie/widgets/ads_by_seller.dart';
import 'package:DaSell/screens/favs/my_ads_screen.dart';
import 'package:DaSell/screens/favs/my_sell_ads_screen.dart';

import '../../commons.dart';
import '../../services/firebase/models/product_vo.dart';
import '../product_details/product_details.dart';
import 'favorite_ads_screen.dart';

abstract class MyAdsScreenState extends State<MyAds> {

   List<ResponseProductVo> myProducts = [];

    void onItemTap(ResponseProductVo vo) {
    context.push(
      ProductDetails(
        data: vo,
      )
    );
    // Navigator.of(context).pushNamed(
    //   ProductDetailScreen.routeName,
    //   arguments: {
    //     'docs': vo,
    //     'isMe': vo.isMe,
    //   },
    // );
  }

   void onItemLike(ResponseProductVo vo) {
    vo.toggleLike();
  }

}

 abstract class FavoriteAdsScreenState extends State<FavoriteAdsScreen> {

   List<ResponseProductVo> myFavProducts = [];

    void onItemTap(ResponseProductVo vo) {
    context.push(
      ProductDetails(
        data: vo,
      )
    );
    // Navigator.of(context).pushNamed(
    //   ProductDetailScreen.routeName,
    //   arguments: {
    //     'docs': vo,
    //     'isMe': vo.isMe,
    //   },
    // );
  }

   void onItemLike(ResponseProductVo vo) {
    vo.toggleLike();
  }

 }

 
 abstract class MySellAdsScreenState extends State<MySellAds> {

   List<ResponseProductVo> mySellProducts = [];

    void onItemTap(ResponseProductVo vo) {
    context.push(
      ProductDetails(
        data: vo,
      )
    );
    // Navigator.of(context).pushNamed(
    //   ProductDetailScreen.routeName,
    //   arguments: {
    //     'docs': vo,
    //     'isMe': vo.isMe,
    //   },
    // );
  }

   void onItemLike(ResponseProductVo vo) {
    vo.toggleLike();
  }

 }


  abstract class AdsBySellerScreenState extends State<AdsBySeller> {

   List<ResponseProductVo> adsBySeller = [];

    void onItemTap(ResponseProductVo vo) {
    context.push(
      ProductDetails(
        data: vo,
      )
    );
    // Navigator.of(context).pushNamed(
    //   ProductDetailScreen.routeName,
    //   arguments: {
    //     'docs': vo,
    //     'isMe': vo.isMe,
    //   },
    // );
  }

   void onItemLike(ResponseProductVo vo) {
    vo.toggleLike();
  }

 }