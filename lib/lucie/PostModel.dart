// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.categories,
    required this.condition,
    required this.createdAt,
    required this.description,
    required this.id,
    required this.isFav,
    required this.isSold,
    //required this.locationAddress,
    required this.latitude,
    required this.longitude,
    required this.makeShipments,
    required this.price,
    required this.title,
    required this.uid,
  });

  List<String>? categories;
  String? condition;
  Timestamp? createdAt;
  String? description;
  int? id;
  bool? isFav;
  bool? isSold;
  //String locationAddress;
  double? latitude;
  double? longitude;
  bool? makeShipments;
  double? price;
  String? title;
  String? uid;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    categories: List<String>.from(json["categories"].map((x) => x)),
    condition: json["condition"],
    createdAt: json["createdAt"],
    description: json["description"],
    id: json["id"],
    isFav: json["isFav"],
    isSold: json["isSold"],
    //locationAddress: json["location address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    makeShipments: json["makeShipments"],
    price: json["price"],
    title: json["title"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories!.map((x) => x)),
    "condition": condition,
    "createdAt": createdAt,
    "description": description,
    "id": id,
    "isFav": isFav,
    "isSold": isSold,
    //"location address": locationAddress,
    "latitude": latitude,
    "longitude": longitude,
    "makeShipments": makeShipments,
    "price": price,
    "title": title,
    "uid": uid,
  };
}
