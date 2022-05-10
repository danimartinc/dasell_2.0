import '../commons.dart';

class UserReview {

  
  final String reviewerName;
  final String reviewerPhoto;
  final double rating;
  final String comment;
  final String reviewerid;
  final String commentid;
  final Timestamp? date;

  UserReview({
    required this.reviewerName,
    required this.reviewerPhoto,
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerid,
    required this.commentid
  });


  factory UserReview.fromJson(Map<String, dynamic> json) {

    //print(json["date"]);

    return UserReview(
      reviewerName: json["reviewerName"],
      reviewerPhoto: json["reviewerPhoto"],
      rating: json["rating"].toDouble(),
      comment: json["comment"],
      date: json["date"],
      reviewerid: json["reviewerid"],
      commentid: json["commentid"]
    );
  }
  

  Map<String, dynamic> toJson() => {
    "reviewerName": reviewerName,
    "reviewerPhoto": reviewerPhoto,
    "rating": rating,
    "comment": comment,
    "date": date,
    "reviewerid":reviewerid,
    "commentid":commentid
  };

  /*String get textTime {
    if (date  == null) {
      return "";
    }
    return AppUtils.getTimeAgoText(date!);
  }*/
}