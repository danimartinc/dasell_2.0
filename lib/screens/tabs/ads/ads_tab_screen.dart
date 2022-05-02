import '../../../commons.dart';

//Screens
import '../../favs/my_ads_screen.dart';
import '../../favs/favorite_ads_screen.dart';
import '../../favs/my_sell_ads_screen.dart';

class AdsTabScreen extends StatefulWidget {

  @override
  _AdsTabScreenState createState() => _AdsTabScreenState();
}

class _AdsTabScreenState extends State<AdsTabScreen> {

  final tabs = [
    MyAds(),
    FavoriteAdsScreen(),
    MySellAds(),
  ];
  
  @override
  Widget build(BuildContext context) {

    final menuTabProviderIndex = Provider.of<TabMenuProvider>(context).index;

    return DefaultTabController(
      initialIndex: menuTabProviderIndex,
      length: tabs.length,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 5,
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new TabBar(
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                physics: BouncingScrollPhysics(),
                labelStyle: TextStyle(
                  fontSize: 17,
                ),
                tabs: [
                  Tab( text: '  Publicados   ', ),
                  Tab( text: '  Favoritos  ', ),
                  Tab( text: '  Vendidos  ', ),
                ],
                onTap: (index) =>
                  Provider.of<TabMenuProvider>(context, listen: false).setIndex(index)
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: menuTabProviderIndex,
          children: tabs
          ),
        ),
    );
  }
}
