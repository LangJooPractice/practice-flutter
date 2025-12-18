// ignore_for_file: public_member_api_docs, sort_constructors_first
class TweetDetailModel {
  final String type;
  final int? originalTweetId;
  final int tweetId;
  final String content;
  final String createdAt;
  final int userId;
  final String username;
  final String nickname;
  final int likeCount;
  final int retweetCount;
  final int? replyToTweetId;
  final bool likedByMe;
  final bool retweetedByMe;

  TweetDetailModel({
    required this.type,
    required this.originalTweetId,
    required this.tweetId,
    required this.content,
    required this.createdAt,
    required this.userId,
    required this.username,
    required this.nickname,
    required this.likeCount,
    required this.retweetCount,
    required this.replyToTweetId,
    required this.likedByMe,
    required this.retweetedByMe,
  });

  factory TweetDetailModel.fromJson(Map<String, dynamic> json) {
    return TweetDetailModel(
      type: json["type"],
      originalTweetId: (json["originalTweetId"] as num?)?.toInt(),
      tweetId: (json["tweetId"] as num).toInt(),
      content: json['content'],
      createdAt: json['createdAt'],
      userId: (json['userId'] as num).toInt(),
      username: json['username'],
      nickname: json['nickname'],
      likeCount: (json['likeCount'] as num).toInt(),
      retweetCount: (json['retweetCount'] as num).toInt(),
      replyToTweetId: (json['replyToTweetId'] as num?)?.toInt(),
      likedByMe: json['likedByMe'],
      retweetedByMe: json['retweetedByMe'],
    );
  }
}
