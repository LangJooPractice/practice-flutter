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

  //TODO : 그냥 좋아요값만을 return하는 api가 필요함

  //해당 메소드는 post한후 좋아요 상태를 "변환"시키는 post작업이므로
  //이전 상태를 불러오기 위해서는 "두번"실행해야함
  //원래상태 = 1,true ->한번 0, false -> 두번 1,true
  //아니면 그냥 트윗 상세 페이지 값 가져와서 파싱해도 되긴 함
  Future<LikeResponse> fetchLike(String tweetId) async {
    final res2 = await dio.post('/api/tweets/$tweetId/like');
    final res1 = await dio.post('/api/tweets/$tweetId/like');

    return LikeResponse.fromJson(res1.data);
  }
}
