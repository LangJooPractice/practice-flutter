// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:prac/models/others/tweet_detail_model.dart';

class TweetDetailService {
  final Dio dio;

  TweetDetailService(this.dio);

  Future<TweetDetailModel> getTweetDetail(String? tweetId) async {
    final response = await dio.get('/api/tweets/$tweetId');

    return TweetDetailModel.fromJson(response.data);
  }
}
