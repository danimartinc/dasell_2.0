import 'commons.dart';

import 'maps/screens/screens.dart';
import 'screens/add/add_images/adding_images_screen.dart';
import 'screens/add/further_cat/further_cat.dart';
import 'screens/add/price_location/price_and_location_screen.dart';
import 'screens/add/product_info_one/product_info_one.dart';
import 'screens/bottom_navigation.dart';
import 'screens/home/product_detail_screen.dart';
import 'widgets/loading/data_backup_home.dart';
import 'package:DaSell/screens/favs/my_sell_ads_screen.dart';



  Map<String, Widget Function(BuildContext)> routes = {

    //UsersChatScreen.routeName: (context) => UsersChatScreen(),
    FurtherCat.routeName: (context) => FurtherCat(),
    ProductInfoOne.routeName: (context) => ProductInfoOne(),
    AddingImagesScreen.routeName: (context) => AddingImagesScreen(),
    PriceAndLocationScreen.routeName: (context) => PriceAndLocationScreen(),
    BottomNavigationScreen.routeName: (context) => BottomNavigationScreen(),
    //Navegar normalmente
    ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
    //ChatScreen.routeName: (context) => ChatScreen(),
    AddProduct.routeName: (context) => AddProduct(),
    HomeScreen.routeName: (context) => HomeScreen(),
    DataBackupHome.routeName: (context) => DataBackupHome(),
    MapLoadingScreen.routeName: (context) => MapLoadingScreen(),
    MySellAds.routeName: (context) => MySellAds(),   
  };






