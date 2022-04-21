import '../../commons.dart';


//Data
import 'package:DaSell/data/categories.dart';

//Screens
import 'package:auto_size_text/auto_size_text.dart';


import '../add/maps/maps_screen.dart';
import '../chat_room/chat_screen.dart';

class ProductDetailScreen extends StatefulWidget {

  static const routeName = './product_detail_screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  
  final Map<int, String> cal = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  String mapUrl = '';
  int current = 0;
  AdLocation? loc;
  late BuildContext ctx;
  var docId;
  bool isSold = false;

  //Método
  void deleteAd(BuildContext ctx) async {
    Navigator.of(ctx).pop();

    await FirebaseFirestore.instance
        .collection('products')
        .doc(
          docId.toString(),
        )
        .delete();
  }

  //Método que permite marcar un producto como vendido
  void markAsSold(BuildContext ctx) async {
    Navigator.of(ctx).pop();

    await FirebaseFirestore.instance
        .collection('products')
        .doc(
          docId.toString(),
        )
        .update({'isSold': true});

    setState(() {
      isSold = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Mediante MediaQuery, obtengo el ancho de pantalla disponible del dispositivo
    final width = MediaQuery.of(context).size.width;

    ctx = context;

    // UserModel? userData;
    UserVo? userData;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    dynamic documents = args['docs'];
    docId = documents['id'];
    final bool isMe = args['isMe'];
    isSold = documents['isSold'];
    final images = documents['images'] as List<dynamic>;
    Timestamp dateTime = documents['createdAt'];

    mapUrl =
        Provider.of<AdProvider>(context, listen: false).getLocationFromLatLang(
      latitude: (documents['location']['latitude'] as double?),
      longitude: (documents['location']['longitude'] as double?),
    );

    //final data = ModalRoute.of(context)!.settings.arguments as Map<String?, dynamic>;
    //final indexCategory = data["indexCategory"];
    //final indexFurther  = data["indexFurther"];

    int indexCategory = Categories.categories.indexWhere(
        (element) => element['category'] == documents['categories'][0]);

    final cats = Categories.categories[indexCategory];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0x44000000),
        actions: isMe
            ? [
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Eliminar publicación'),
                      value: 'delete',
                    ),
                    PopupMenuItem(
                      child: Text('Marcar artículo como vendido'),
                      value: 'sell',
                    )
                  ],
                  onSelected: (value) {
                    if (value == 'delete') {
                      showDialog(
                        context: ctx,
                        builder: (context) => AlertDialog(
                          title: Text('Eliminar esta publicación'),
                          content: Text(
                              '¿Está seguro de querer eliminar esta publicación?'),
                          actions: [
                            TextButton(
                              child: Text(
                                'Salir',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                onPrimary: Colors.white,
                                //elevation: 0,
                                //tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.zero,
                                //),
                              ),
                              //color: Theme.of(context).primaryColor,
                              //textColor: Colors.white,
                              child: Text('Confirmar'),
                              onPressed: () {
                                deleteAd(context);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (value == 'sell') {
                      showDialog(
                        context: ctx,
                        builder: (context) => AlertDialog(
                          title: Text('Marcar cómo vendido'),
                          content: Text(
                              '¿Deseas ocultar este artículo como publicado para el resto de usuarios?'),
                          actions: [
                            TextButton(
                              child: Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                onPrimary: Colors.white,
                                //elevation: 0,
                                //tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                //shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.zero,
                                //),
                              ),
                              //color: Theme.of(context).primaryColor,
                              //textColor: Colors.white,
                              child: Text('Confirmar'),
                              onPressed: () {
                                markAsSold(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ]
            : [],
      ),
      body: FutureBuilder<UserVo?>(
          future: Provider.of<AdProvider>(context).getUserDataFromUid(
            documents['uid'],
          ),
          builder: (context, userSnapshot) {
            //Comprobamos que si tenemos información
            if (userSnapshot.hasData) {
              //Widget con la información
              userData = userSnapshot.data;

              return FutureBuilder(
                  future: Provider.of<AdProvider>(context, listen: false)
                      .getDistanceFromCoordinates(
                    documents['location']['latitude'] as double?,
                    documents['location']['longitude'] as double?,
                  ),
                  builder: (context, locSnapshot) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Hero(
                                  tag: documents['id'],
                                  child: CarouselSlider.builder(
                                    itemCount: images.length,
                                    itemBuilder: (ctx, int i, __) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        width: double.infinity,
                                        height: 200,
                                        child: CachedNetworkImage(
                                          imageUrl: images[i],
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: 300.0,
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 1,
                                      enableInfiniteScroll: false,
                                      enlargeCenterPage: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 15),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          current = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: images.map((url) {
                                        int index = images.indexOf(url);
                                        return Container(
                                          width: 8.0,
                                          height: 8.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: current == index
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Colors.grey,
                                          ),
                                        );
                                      }).toList()),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                isSold ? 'Vendido' : '${documents['price']} €',
                                style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                documents['title'],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.boxOpen),
                                  SizedBox(width: 30),
                                  Text(
                                    documents['makeShipments'] == true
                                        ? 'Acepta envíos - desde 2,50 €'
                                        : 'No admite envíos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: documents['makeShipments'] == true
                                          ? Colors.pink[200]
                                          : Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  MaterialButton(
                                      minWidth: width - 240,
                                      child: Text(documents['categories'][0],
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.indigo,
                                      //Redondeamos los bordes del botón
                                      shape: StadiumBorder(),
                                      elevation: 0,
                                      splashColor: Colors.transparent,
                                      //Disparamos el método getCoordsStartAndDestination para confirmar el destino
                                      onPressed: () => {
                                            //this.calculateDestinationRoute( context );
                                            //Navigator.of(context).pushNamed( HomeScreen.routeName );
                                          }),
                                  MaterialButton(
                                      minWidth: width - 240,
                                      child: Text(documents['categories'][1],
                                          style:
                                              TextStyle(color: Colors.white)),
                                      color: Colors.indigo,
                                      //Redondeamos los bordes del botón
                                      shape: StadiumBorder(),
                                      elevation: 0,
                                      splashColor: Colors.transparent,
                                      //Disparamos el método getCoordsStartAndDestination para confirmar el destino
                                      onPressed: () => {
                                            //this.calculateDestinationRoute( context );
                                            //Navigator.of(context).pushNamed( HomeScreen.routeName );
                                      }
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.menu_book_outlined,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                              'Estado del artículo:\n' +
                                                  (documents['condition'] ??
                                                      ""),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: locSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Text(
                                                    (locSnapshot.data
                                                                as double) <
                                                            1000
                                                        ? '${(locSnapshot.data as double).toStringAsFixed(2)} m desde tu ubicación'
                                                        : '${((locSnapshot.data as double) / 1000).toStringAsFixed(2)} km desde tu ubicación',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Fecha de publicación',
                                            style: TextStyle(
                                                fontFamily: 'Poppins'),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            dateTime.toDate().day.toString() +
                                                ' ' +
                                                cal[dateTime.toDate().month]!,
                                            style: TextStyle(
                                                fontFamily: 'Poppins'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.withOpacity(
                                    0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    userSnapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : userSnapshot.data!.profilePicture ==
                                                ''
                                            ? Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: SvgPicture.asset(
                                                    'assets/images/boy.svg'),
                                              )
                                            : CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                  userSnapshot
                                                      .data!.profilePicture!,
                                                ),
                                              ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Producto publicado por',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        userSnapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Text(
                                                isMe
                                                    ? 'Ti'
                                                    : userSnapshot
                                                        .data!.textName,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: AutoSizeText(
                                documents['description'],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                ),

                                minFontSize: 18,
                                maxLines: 4,
                                //overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            kGap25,
                            if ((documents['location']['address'] as String)
                                .isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Icon(
                                        FontAwesomeIcons.mapMarkedAlt,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          '${documents['location']['address']}',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18),
                                          minFontSize: 18,
                                          maxLines: 4,
                                        ),
                                      )
                                    ]),
                                  ],
                                ),
                              ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => ClipRRect(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ProductGoogleMapScreen(
                                          placeLocation: AdLocation(
                                            latitude: documents['location']
                                                ['latitude'] as double,
                                            longitude: documents['location']
                                                ['longitude'] as double,
                                            address: '',
                                          ),
                                          isEditable: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: mapUrl.isEmpty
                                        ? Text('No hay ubicación')
                                        : Image.network(
                                            mapUrl,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              //CircularProgressIndicator(), permite indicar al usuario que se está cargando información
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            }
          }),
      floatingActionButton: !isMe && !isSold
          ? Container(
              height: 90.0,
              width: 90.0,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 15,
                  label: Text(''),
                  icon: Icon(
                    FontAwesomeIcons.comments,
                  ),
                  onPressed: () {
                    trace("push chat screen?!");
                    Navigator.of(context).pushNamed(
                      ChatRoomScreen.routeName,
                      arguments: userData,
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
