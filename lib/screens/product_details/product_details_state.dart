import 'dart:async';

import 'package:DaSell/commons.dart';
import 'package:DaSell/services/firebase/models/product_vo.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../chat_room/chat_screen.dart';
import 'product_details.dart';
import 'widgets/dialogs.dart';
import 'widgets/widgets.dart';

abstract class ProductDetailsState extends State<ProductDetails> {
  
  bool isSold = false;

  String mapUrl = '';
  UserVo? adUser;

  ResponseProductVo get data => widget.data;
  final _firebaseService = FirebaseService.get();
  int current = 0;

  void onImageChanged(int index) {
    current = index;
    update();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    mapUrl =
        Provider.of<AdProvider>(context, listen: false).getLocationFromLatLang(
      latitude: data.location?.latitude,
      longitude: data.location?.longitude,
    );

    adUser = await _firebaseService.getUser(data.uid!);

    /// context puede no estar disponible.
    Future.microtask(updateAdLocation);
  }

  Future<void> onDeleteTap() async {

    var result = await context.dialog<bool>(DeleteProductAlert());

    if (result == true) {
      await _firebaseService.deleteAd(data.id);
      update();
      Navigator.of(context).pop();
      //Provider.of<MenuProvider>( context, listen: false ).setIndex(0);
      //CustomToastMessage( message: 'Publicación eliminada', backgroundColor: Colors.green.shade600,);
      showDeleteToast();
    }
  }

  void showDeleteToast() => Fluttertoast.showToast(
    msg: 'Publicación eliminada',
    fontSize: 15,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green.shade500,
    textColor: Colors.white,
  );

  Future<void> onSellTap() async {
    var result = await context.dialog(SellAlertDialog());
    if (result == true) {
      await _firebaseService.markAsSold(data.id);
      isSold = true;
      showSellToast();
      update();
    }
  }

  void showSellToast() => Fluttertoast.showToast(
        msg: 'Artículo marcado como vendido',
        fontSize: 15,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green.shade500,
        textColor: Colors.white,
      );

  double locationDistance = -1;

  bool get hasLocation => locationDistance > -1;

  bool get hasAdUser => adUser != null;

  String get locationText {
    late String dist;
    if (locationDistance < 1000) {
      dist = locationDistance.toStringAsFixed(2) + ' m';
    } else {
      dist = (locationDistance / 1000).toStringAsFixed(2) + ' km';
    }
    return '$dist desde tu ubicación';
  }

  Future<FutureOr> updateAdLocation() async {
    final adProvider = Provider.of<AdProvider>(context, listen: false);
    locationDistance = await adProvider
        .getDistanceFromCoordinates(
          data.location?.latitude,
          data.location?.longitude,
        )
        .then((value) => value ?? 0.0);
    update();
  }

  String get textPublicationDate {
    return AppUtils.publicationDate(data.createdAt?.toDate());
  }

  String get textAdUserName {
    if (adUser == null) return '-';
    return data.isMe ? 'Ti' : (adUser?.name ?? 'alguien');
  }

  String get textDescription => data.description ?? '-';

  bool get hasAddress {
    return data.location?.address?.isNotEmpty == true;
  }

  String get textAddress {
    return data.location?.address ?? '-';
  }

  void onCategoryTap(String category) {
    trace("Abrir categoria: $category");
  }

  bool get hasChat {
    return !data.isMe && !data.getIsSold();
  }

  void onChatTap() {
    trace("PUSH CHAT SCREEN 2");
    context.push(ChatRoomScreen(user: adUser!));
    trace("User  ${ adUser } ");
    //     () => Navigator.of(context.pushNamed(
    //   ChatScreen.routeName,
    //   arguments: userData,
    // ),
  }

  void onMapTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => DialogMapScreen(
          lat: data.location?.latitude ?? 0,
          lon: data.location?.longitude ?? 0,
        ),
      ),
    );
  }
}
