import '../commons.dart';

class UserReview {

  
  String reviewerName;
  String reviewerPhoto;
  double rating;
  String comment;
  final Timestamp? date;

  UserReview({
    required this.reviewerName,
    required this.reviewerPhoto,
    required this.rating,
    required this.comment,
    required this.date
    
  });


  factory UserReview.fromJson(Map<String, dynamic> json) {

    //print(json["date"]);

    return UserReview(
      reviewerName: json["reviewerName"],
      reviewerPhoto: json["reviewerPhoto"],
      rating: json["rating"].toDouble(),
      comment: json["comment"],
      date: json["date"]

    );
  }
  

  Map<String, dynamic> toJson() => {
    "reviewerName": reviewerName,
    "reviewerPhoto": reviewerPhoto,
    "rating": rating,
    "comment": comment,
    "date": date,
  };

  /*String get textTime {
    if (date  == null) {
      return "";
    }
    return AppUtils.getTimeAgoText(date!);
  }*/
}