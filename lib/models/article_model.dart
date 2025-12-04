class ArticleModel {
  final String nickname;
  final String nickname_id;
  final String time;
  final String article_string;
  final double comment_num;
  final double retweet_num;
  final double favorite_num;
  final double statistics;
  final String id;

  ArticleModel({
    required this.nickname,
    required this.nickname_id,
    required this.time,
    required this.article_string,
    required this.comment_num,
    required this.retweet_num,
    required this.favorite_num,
    required this.statistics,
    required this.id,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      nickname: json['nickname'],
      nickname_id: json['nickname_id'],
      time: json['time'],
      article_string: json['article_string'],
      comment_num: (json['comment_num'] as num).toDouble(),
      retweet_num: (json['retweet_num'] as num).toDouble(),
      favorite_num: (json['favorite_num'] as num).toDouble(),
      statistics: (json['statistics'] as num).toDouble(),
      id: json['id'],
    );
  }
}
