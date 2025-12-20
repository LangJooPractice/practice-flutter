import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/others/article_model.dart';
import 'package:prac/models/others/like_state.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/services/tweet/like_service.dart';

//ApiService를 반환하는 provider
final likeApiServiceProvider = Provider<LikeService>((ref) {
  //해당 부분에서 dio DI
  final dio = ref.read(dioProvider);
  //LikeService 반환
  return LikeService(dio: dio);
});

final likeProvider = AsyncNotifierProvider.autoDispose
    .family<LikeNotifier, LikeState, ArticleModel>(LikeNotifier.new);

class LikeNotifier extends AsyncNotifier<LikeState> {
  //이거 인수로 받는다는 뜻
  //위에서 선언한 fammily 의 인자를 아래 연관된 notifier의
  //생성자를 통해 저장할 수 있습니다.
  //https://riverpod.dev/docs/concepts2/family
  final ArticleModel article;
  LikeNotifier(this.article);

  //초기값 설정
  @override
  LikeState build() {
    return LikeState(likeCount: article.likeCount, liked: article.likedByMe);
  }

  Future<void> toggleLike() async {
    state = AsyncValue.loading();

    try {
      final res = await ref
          .read(likeApiServiceProvider)
          .toggleLike(article.tweetId);

      state = AsyncValue.data(
        LikeState(likeCount: res.likeCount, liked: res.liked),
      );
    } catch (e) {
      rethrow;
    }
  }
}
