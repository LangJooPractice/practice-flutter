// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:prac/models/others/tweet_detail_model.dart';
import 'package:prac/screen/tweet_profile/profile.dart';

class ProfileModel {
  final int userId;
  final String username;
  final String nickname;
  final String joinedAt;
  final String? bio;
  final String? address;
  final int tweetCount;
  final int followingCount;
  final int followerCount;
  List<TweetDetailModel> recentTweets;
  final bool following;

  ProfileModel({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.joinedAt,
    required this.bio,
    required this.address,
    required this.tweetCount,
    required this.followingCount,
    required this.followerCount,
    required this.recentTweets,
    required this.following,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: (json["userId"] as num).toInt(),
      username: json["username"],
      nickname: json["nickname"],
      joinedAt: json["joinedAt"],
      bio: json['bio'] as String? ?? "bio Null",
      address: json['address'] as String? ?? "address Null",
      tweetCount: (json['tweetCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
      followerCount: (json['followerCount'] as num).toInt(),
      recentTweets: List<TweetDetailModel>.from(
        json["recentTweets"].map((x) => TweetDetailModel.fromJson(x)),
      ),
      following: json["following"],
    );
  }
}
