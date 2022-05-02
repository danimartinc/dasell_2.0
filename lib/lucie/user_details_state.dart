

import 'dart:async';

import 'package:DaSell/lucie/seller_user_details.dart';

import '../commons.dart';
import '../models/user_review.dart';
import '../screens/chat_room/chat_screen.dart';
import '../screens/product_details/widgets/widgets.dart';
import '../services/firebase/models/product_vo.dart';

abstract class SellerUserDetailsState extends State<SellerUserDetails> {

  bool isSold = false;

  String mapUrl = '';
  UserVo? adUser;
  var auth;

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

    auth = FirebaseAuth.instance;



    adUser = await _firebaseService.getUser(data.uid!);

    /// context puede no estar disponible.
    Future.microtask(updateAdLocation);
  }

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

  Future<double?> averageReview( List<UserReview>? list ) async{

    try{

      double average = 0.0;

      list?.forEach((element) {
        average = average + element.rating;
      });

      average = average / list!.length;

      print(average);

      return average;
    }catch(e){
      return null;
    }
  }




  
 }