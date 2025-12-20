import 'package:dio/dio.dart';
import 'package:prac/models/others/like_response.dart';

class LikedApiService {
  //디오 인터셉터 주입
  final Dio dio;

  LikedApiService(this.dio);

  Future<LikeResponse> toggleLike(String tweetId) async {
    final response = await dio.post('/api/tweets/$tweetId/like');

    return LikeResponse.fromJson(response.data);
  }
}
