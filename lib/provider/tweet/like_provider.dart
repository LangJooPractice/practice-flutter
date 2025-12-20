import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/others/article_model.dart';
import 'package:prac/models/others/like_state.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/services/tweet/liked_api_service.dart';

final likeApiProvider = Provider<LikedApiService>((ref) {
  final dio = ref.watch(dioProvider);

  return LikedApiService(dio);
});

final likeProvider = AsyncNotifierProvider.autoDispose
    .family<LikeNotifier, LikeState, ArticleModel>(LikeNotifier.new);

class LikeNotifier extends AsyncNotifier<LikeState> {
  LikeNotifier(this.article);
  final ArticleModel article;

  @override
  Future<LikeState> build() async {
    // ✅ ArticleModel 기반 초기화
    return LikeState(
      isLiked: article.likedByMe,
      likeCount: article.likeCount.toInt(),
    );
  }

  Future<void> toggleLike() async {
    state = const AsyncValue.loading();

    try {
      final res = await ref
          .read(likeApiProvider)
          .toggleLike(article.tweetId.toString());

      state = AsyncValue.data(
        LikeState(isLiked: res.liked, likeCount: res.likeCount),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
