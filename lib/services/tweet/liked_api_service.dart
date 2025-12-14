import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LikedApiService {
  final Dio dio;

  LikedApiService(this.dio);

  Future<bool> pressLike(String tweetId) async {
    final response = await dio.post('/api/tweets/$tweetId/like');

    return response.data['isLiked'] as bool;
  }
}
