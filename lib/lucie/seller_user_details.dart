import '../commons.dart';

import 'package:DaSell/lucie/user_details_state.dart';
import 'package:DaSell/lucie/widgets/ads_by_seller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                        return Container(
                          color: Colors.grey.shade100,
                          width: MediaQuery.of(context).size.width,
                          height: 80,
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
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: RatingBarIndicator(
                                        itemSize: 14,
                                        rating: userreview![index].rating,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userreview[index].reviewerName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(userreview[index].comment)
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
                    Text( '¿Cómo valoras tu experiencia con ${ textAdUserName }?',
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
                        print(FirebaseService.get().uid);
                        UserReview revi = new UserReview(reviewerName: asd.name ?? "", reviewerPhoto: asd.profilePicture ?? "", rating: rating, comment: commentController.text);
                        print( "REVIEWER: ${revi.toJson()}" );

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
                        userreview!.add(revi);

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
