// To parse this JSON data, do
//
//     final userVo = userVoFromJson(jsonString);

// const firebaseConfig = {
//   apiKey: "AIzaSyC9oIhVx-R9orUyVXorJSqn_AAfVn0tI9o",
//   authDomain: "shop-chat-88e88.firebaseapp.com",
//   databaseURL: "https://shop-chat-88e88-default-rtdb.europe-west1.firebasedatabase.app",
//   projectId: "shop-chat-88e88",
//   storageBucket: "shop-chat-88e88.appspot.com",
//   messagingSenderId: "40523523478",
//   appId: "1:40523523478:web:d23530025a6de670d969b7",
//   measurementId: "G-H6N165G0VX"
// };

// https://firestore.googleapis.com/v1/projects/shop-chat-88e88/databases/(default)/documents/chats

import 'user_review.dart';

class UserVo {
  
  String? _uid, _profilePicture, _name, _email, _token, _status;
  List<UserReview>? _reviews;
  double? _averageReview;

  UserVo({
    String? uid,
    String? profilePicture,
    String? name,
    String? email,
    String? token,
    String? status,
    List<UserReview>? reviews,
    double? averageReview

  }) {
    this._uid = uid;
    this._profilePicture = profilePicture;
    this._name = name;
    this._email = email;
    this._token = token;
    this._status = status;
    this._reviews = reviews;
    this._averageReview = averageReview! + 0.0;
  }

  String get uid => _uid!;

  String? get profilePicture => _profilePicture;

  String? get name => _name;

  String? get email => _email;

  String? get token => _token;

  String? get status => _status;

  String get textStatus => _status ?? '';

  String get textName => name ?? '-';

  double? get averageReview => _averageReview! + 0.0;

  List<UserReview> get reviews => _reviews ?? [];

  @override
  String toString() {
    return 'UserVo2{_uid: $_uid, _profilePicture: $_profilePicture, _name: $_name, _email: $_email, _token: $_token, _status: $_status}';
  }

  UserVo.fromJson(dynamic json) {
    _uid = json['uid'];
    _profilePicture = json['profilePicture'];
    _name = json['name'];
    _email = json['email'];
    _token = json['token'];
    _status = json['status'];
    _reviews = json["reviews"] != null ? List<UserReview>.from(json["reviews"]!.map((x) => UserReview.fromJson(x))) : [];
    _averageReview = json['averageReview'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this._uid;
    data['profilePicture'] = this._profilePicture;
    data['name'] = this._name;
    data['email'] = this._email;
    data['token'] = this._token;
    data['status'] = this._status;
    data['reviews'] = List<dynamic>.from( reviews.map((x) => x.toJson()));
    data['averageReview'] = this._averageReview;
    return data;
  }


}
