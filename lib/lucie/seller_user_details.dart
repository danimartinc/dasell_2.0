import 'dart:convert';

import 'package:DaSell/lucie/widgets/modal_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../commons.dart';

import 'package:DaSell/lucie/user_details_state.dart';
import 'package:DaSell/lucie/widgets/ads_by_seller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../services/firebase/models/product_vo.dart';
import 'widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;


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

class _SellerUserDetailsState extends SellerUserDetailsState
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final commentController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    List<UserReview>? userreview = adUser?.reviews;
    final dateNow = Timestamp.now();
    final timeNow =  dateNow.toDate();
    
  String _selectedItem = '';
    
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
                  Text(
                    textAdUserName,
                    style: TextStyle(fontSize: 25),
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        itemSize: 14,
                        rating: adUser?.averageReview ?? 0.0,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text("(" +  ( userreview?.length.toString() ?? "0" ) + ")")
                    ],
                  ),
                ],
              ),
              if (hasAdUser)
                ProductUserAvatarDetails(imageUrl: adUser?.profilePicture),
            ],
          ),
        ),
        Container(
          child: TabBar(
            labelColor: Colors.black,
            controller: _controller,
            tabs: [
              Tab(
                text: 'En venta',
              ),
              Tab(
                icon: Text( ( userreview?.length.toString() ?? "0" ) ),
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
                adUser != null
                    ? AdsBySeller(
                        uid: adUser?.uid,
                      )
                    : Container(),
                //Container(color: Colors.green,),
                Container(
                  child: ListView.builder(
                      itemCount: userreview?.length,
                      itemBuilder: (context, index) {

                        DateTime? reviewDate =  userreview?[index].date?.toDate() ?? null;

                        String formatDate = DateFormat('dd-MM-yyyy').format( reviewDate! );
                
                        return Container(
                          color: Colors.grey.shade100,
                          width: MediaQuery.of(context).size.width,
                          height: 180,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: userreview?[index].reviewerPhoto == '' || userreview?[index].reviewerPhoto == null
                                //name: doc.data()['name'] ?? ''
                                ? CircleAvatar(
                                  radius: 25,
                                  child: SvgPicture.asset(
                                    'assets/images/boy.svg',
                                  ),
                                )
                                : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    userreview![index].reviewerPhoto,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FirebaseAuth.instance.currentUser?.uid == userreview![index].reviewerid?Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(Icons.more_vert, color: Theme.of(context).primaryColor,),
                                                    onPressed: () =>   showModalBottomSheet(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          color: Color(0xFF737373),
                                                          height: 140,
                                                          child: Container(
                                                            child: Column(
                                                              children: [ 
                                                                BottomNavigationMenu(
                                                                  icon: Icon(FontAwesomeIcons.pencilAlt),
                                                                  text: Text('Editar opinión'), 
                                                                  onTap: () {    
                                     
                                          double rating = 1;
                                          commentController.text = userreview[index].comment;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  content: Container(
                                                    height: 250,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text( '¿Cómo valoras tu experiencia con $textAdUserName ?',
                                                          style: TextStyle(
                                                            color: Colors.black87,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text( 'Valora al vendedor y ayuda a otros usuarios en futuras ventas',
                                                          textAlign: TextAlign.center,),
                                                        RatingBar.builder(
                                                          initialRating: userreview[index].rating,
                                                          minRating: 1,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                          itemBuilder: (context, _) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: ( ratingg ) {
                                                            rating = ratingg;
                                                          },
                                                        ),
                                                        TextFormField(
                                                          decoration: InputDecoration(hintText: "Introduce un comentario..."),
                                                          controller: commentController,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {

                                                            print( 'TIMESTAMP $dateNow');

                                                            // Map<String, dynamic> rate = {
                                                            //   "rating": 1,
                                                            //   "comment": "fdfsdfsdfsdfdfgdgdfgdfgdfgfhfhfghfhg43gg2423423",
                                                            //   //"reviewerId":FirebaseService.get().auth.currentUser?.uid,
                                                            //   "reviewerName":FirebaseService.get().myUserVo?.name,
                                                            //   "reviewerPhoto":FirebaseService.get().myUserVo?.profilePicture,
                                                            // };
                                                            UserVo asd = await FirebaseService.get().getUser(FirebaseService.get().uid);
                                                            print(asd);
                                                            //print(FirebaseService.get().myUserVo?.toJson());
                                                            print(asd.uid);

                                                            UserReview revi = new UserReview(
                                                                reviewerName: userreview[index].reviewerName,
                                                                reviewerPhoto: userreview[index].reviewerPhoto,
                                                                rating: rating,
                                                                comment: commentController.text,
                                                                date: dateNow,
                                                                reviewerid: userreview[index].reviewerid,
                                                                commentid: userreview[index].commentid
                                                            );
                                                            print( 'TIMENOW $timeNow');


                                                            print( "REVIEWER: ${userreview.asMap()}" );

                                                            userreview[index] = revi;

                                                            var average = await averageReview(userreview);

                                                            //var json = jsonEncode(userreview.map((e) => e.toJson()));
                                                            var json = userreview.map((e) => e.toJson());
                                                            print(json.toList(
                                                            ));

                                                            FirebaseService.get()
                                                                .firestore
                                                                .collection("users")
                                                                .doc( adUser?.uid )
                                                                .update(
                                                                {
                                                                  "reviews": json.toList(), "averageReview" : average
                                                                }
                                                            );

                                                            print("in");
                                                            print( 'trata $textTime');

                                                            setState(() {
                                                              commentController.clear();

                                                            });
                                                            context.pop();

                                                            //var tuh = await FirebaseFirestore.instance.collection("users").doc(adUser?.uid).get();
                                                            //print(tuh.data());
                                                            //print(adUser?.reviews![0].comment);
                                                          },
                                                          child: Container(
                                                            color: Theme.of(context).primaryColor,
                                                            width: MediaQuery.of(context).size.width,
                                                            height: 50,
                                                            child: Center(
                                                                child: Text(
                                                                  'Enviar',
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                )
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            },
                                          );
                                        
                                          }, ),
                                                                BottomNavigationMenu(
                                                                  icon: Icon(Icons.delete),
                                                                  text: Text('Eliminar opinión'), 
                                                                  onTap: () async {   

                                                                    var deleteData = userreview[index].toJson();
                                                                    userreview.removeAt(index);

                                                                    var average = await averageReview(userreview);
                                                                    FirebaseService.get()
                                                                        .firestore
                                                                        .collection("users")
                                                                        .doc( adUser?.uid )
                                                                        .update(
                                                                        {
                                                                          "reviews": FieldValue.arrayRemove([deleteData]), "averageReview" : average
                                                                        }


                                                                    );
                                                                    setState(() {});
                                                                  },
                                                                )
                                          
                                                      ],
                                                      ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).canvasColor,
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: const Radius.circular(10),
                                                        topRight: const Radius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }), 
                                                  ),
                                                  Text(
                                                    _selectedItem,
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
   
                                      ],
                                    )
                                    ):Container(),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: RatingBarIndicator(
                                        itemSize: 14,
                                        rating: userreview[index].rating,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userreview[index].reviewerName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        kGap10,
                                        Text(userreview[index].comment),
                                        kGap5,
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            formatDate,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FirebaseService.get().myUserVo?.uid != adUser?.uid
          ?
      FloatingActionButton(
        onPressed: () {
          double rating = 1;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text( '¿Cómo valoras tu experiencia con $textAdUserName ?',
                    style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),  
                    ),
                    Text( 'Valora al vendedor y ayuda a otros usuarios en futuras ventas',
                    textAlign: TextAlign.center,),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: ( ratingg ) {
                        rating = ratingg;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Introduce un comentario..."),
                      controller: commentController,
                    ),
                    InkWell(
                      onTap: () async {

                     print( 'TIMESTAMP $dateNow');

                        // Map<String, dynamic> rate = {
                        //   "rating": 1,
                        //   "comment": "fdfsdfsdfsdfdfgdgdfgdfgdfgfhfhfghfhg43gg2423423",
                        //   //"reviewerId":FirebaseService.get().auth.currentUser?.uid,
                        //   "reviewerName":FirebaseService.get().myUserVo?.name,
                        //   "reviewerPhoto":FirebaseService.get().myUserVo?.profilePicture,
                        // };
                        UserVo asd = await FirebaseService.get().getUser(FirebaseService.get().uid);
                        print(asd);
                        //print(FirebaseService.get().myUserVo?.toJson());
                        print(asd.uid);

                        UserReview revi = new UserReview(
                            reviewerName: asd.name ?? "", 
                            reviewerPhoto: asd.profilePicture ?? "", 
                            rating: rating, 
                            comment: commentController.text, 
                            date: dateNow,
                            reviewerid: asd.uid,
                          commentid: userreview!.length.toString()
                        );

                        print( "REVIEWER: ${revi.toJson()}" );

                        userreview.add(revi);

                        var average = await averageReview(userreview);

                        FirebaseService.get()
                            .firestore
                            .collection("users")
                            .doc( adUser?.uid )
                            .update(
                              {
                                "reviews": FieldValue.arrayUnion([ revi.toJson() ]), "averageReview" : average
                              }
                            );

                        print("in");
                        print( 'trata $textTime');

                        setState(() {
                          commentController.clear();

                        });
                        context.pop();

                        //var tuh = await FirebaseFirestore.instance.collection("users").doc(adUser?.uid).get();
                        //print(tuh.data());
                        //print(adUser?.reviews![0].comment);
                      },
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),  
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ));
            },
          );
        },
        child: Icon( FontAwesomeIcons.pen),
      ) : Container(),
    );
  }
}

class BottomNavigationMenu extends StatelessWidget {

  final VoidCallback onTap;
  final Icon icon;
  final Text text;

  const BottomNavigationMenu({Key? key, required this.onTap, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

        return ListTile(
          leading: icon,
          title: text,
          onTap: onTap,
        );
  }
}