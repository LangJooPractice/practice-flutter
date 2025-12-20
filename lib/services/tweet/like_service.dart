import 'package:dio/dio.dart';
import 'package:prac/models/others/like_response.dart';

class LikeService {
  //provider선언시 Dio DI
  final Dio dio;

  LikeService({required this.dio});

  //LikeReponse 형태로 LikeNotifier에 전달해주고
  //LikeNotifier에서 해당 reponse를 판단하도록 함

  //toggleLike의 인자는 NotifierProvider에서 family provider를 통해 제공받은
  //ArticleModel의 tweetId를 사용합니다.
  Future<LikeResponse> toggleLike(int tweetId) async {
    final response = await dio.post('/api/tweets/$tweetId/like');

    return LikeResponse.fromJson(response.data);
  }
}
