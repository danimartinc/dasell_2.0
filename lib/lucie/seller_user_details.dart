import 'dart:io';

import 'package:DaSell/lucie/user_details_state.dart';
import 'package:DaSell/lucie/widgets/ads_by_seller.dart';
import 'package:DaSell/screens/product_details/product_details_state.dart';

import '../commons.dart';
import '../screens/product_details/widgets/widgets.dart';
import '../services/firebase/models/product_vo.dart';
import 'widgets/widgets.dart';

class SellerUserDetails extends StatefulWidget {

  final ResponseProductVo data;

  static const routeName = './user_details';

  const SellerUserDetails({
    Key? key,
    required this.data,  
  }) : super(key: key);

  @override
  createState() => _SellerUserDetailsState();
}

class _SellerUserDetailsState extends SellerUserDetailsState with SingleTickerProviderStateMixin {

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller =  TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( textAdUserName,style: TextStyle(fontSize: 25),),
                    Row(children: [
                      Icon(Icons.star,size: 15,),
                      Icon(Icons.star,size: 15,),
                      Icon(Icons.star,size: 15,),
                      Icon(Icons.star,size: 15,),
                      Icon(Icons.star,size: 15,),
                      Text("(2)",style: TextStyle(fontSize: 10),)
                    ],)
                  ],
                ),
                if (hasAdUser)
                ProductUserAvatarDetails(imageUrl: adUser?.profilePicture),
              ],
            ),
          ),
          Container(
            child:  TabBar(
              labelColor: Colors.black,
              controller: _controller,
              tabs: [
                 Tab(
                  icon: Text("3"),
                  text: 'En venta',
                ),
                 Tab(
                  icon: Text("2"),
                  text: 'Opiniones',
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 80.0,
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  adUser != null ? AdsBySeller(uid: adUser?.uid,):Container(),
                  //Container(color: Colors.green,),
                  Container(color: Colors.red,)
                ],
              ),
            ),
          ),
    ]
    ));
  }
}

