import 'package:DaSell/screens/product_details/product_details_state.dart';

import '../commons.dart';
import '../screens/product_details/widgets/widgets.dart';

class UserDetails extends StatefulWidget {
  var data;

  UserDetails({
    Key? key,
    required this.data,
  }) : super(key: key);


  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> with SingleTickerProviderStateMixin{

  late TabController _controller;

  //late ProductDetailsState state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =  TabController(length: 2, vsync: this);
    //state = Provider.of<ProductDetailsState>(context);
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
                    Text("textAdUserName",style: TextStyle(fontSize: 25),),
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
                //if (hasAdUser)
                CircleAvatar(
                  radius: 40,
                  //backgroundImage: NetworkImage(adUser?.profilePicture ?? ""),
                )
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
                  Container(color: Colors.green,),
                  Container(color: Colors.red,)
                ],
              ),
            ),
          ),
    ]
    ));
  }
}