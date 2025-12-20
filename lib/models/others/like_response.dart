// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikeResponse {
  final int tweetId;
  final int likeCount;
  final bool liked;

  LikeResponse({
    required this.tweetId,
    required this.likeCount,
    required this.liked,
  });

  factory LikeResponse.fromJson(Map<String, dynamic> json) {
    return LikeResponse(
      tweetId: (json["tweetId"] as num).toInt(),
      likeCount: (json['likeCount'] as num).toInt(),
      liked: json['liked'],
    );
  }
}
