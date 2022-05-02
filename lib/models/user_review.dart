
class UserReview {

  UserReview({
    required this.reviewerName,
    required this.reviewerPhoto,
    required this.rating,
    required this.comment,
  });

  String reviewerName;
  String reviewerPhoto;
  double rating;
  String comment;

  factory UserReview.fromJson(Map<String, dynamic> json) => UserReview(
    reviewerName: json["reviewerName"],
    reviewerPhoto: json["reviewerPhoto"],
    rating: json["rating"].toDouble(),
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "reviewerName": reviewerName,
    "reviewerPhoto": reviewerPhoto,
    "rating": rating,
    "comment": comment,
  };
}