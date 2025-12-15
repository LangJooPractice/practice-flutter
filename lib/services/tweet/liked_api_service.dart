import 'package:dio/dio.dart';

class LikedApiService {
  //디오 인터셉터 주입
  final Dio dio;

  LikedApiService(this.dio);

  Future<bool> pressLike(String tweetId) async {
    final response = await dio.post('/api/tweets/$tweetId/like');

    return response.data['isLiked'] as bool;
  }
}
