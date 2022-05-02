import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

//Models
import '../models/ad_location.dart';

class AdModel {
  
  String? id;
  double? price;
  String? title;
  String? description;
  List<dynamic>? categories;
  List<File>? fileImages;
  Timestamp? createdAt;
  List<dynamic>? images;
  List<Asset>? imageAssets;
  String? userId;
  AdLocation? location;
  String? condition;
  bool? isSold;
  bool? isFav;
  double? fromLoc;
  bool? makeShipments;

  AdModel({
    this.id,
    this.price,
    this.title,
    this.categories,
    this.description,
    this.createdAt,
    this.fileImages,
    this.images,
    this.imageAssets,
    this.userId,
    this.location,
    this.condition,
    this.isSold,
    this.isFav,
    this.fromLoc,
    this.makeShipments
  });
}
