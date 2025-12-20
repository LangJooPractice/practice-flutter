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
