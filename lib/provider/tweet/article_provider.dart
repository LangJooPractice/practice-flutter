// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:prac/models/others/article_model.dart';
// import 'package:prac/provider/dio/dio_provider.dart';
// import 'package:prac/provider/tweet/comment_control_provider.dart';
// import 'package:prac/services/tweet/article_api_service.dart';

// //apiservice 인스턴스를 반환합니다
// //디오 프로바이더를 구독합니다.
// final articleApiServiceProvider = Provider<ArticleApiService>((ref) {
//   final dio = ref.watch(dioProvider);
//   return ArticleApiService(dio: dio);
// });

// //apiservice 인스턴스를 생성하고 구독합니다. -> 이후 service에서 FETCH
// final ArticleProvider = FutureProvider<List<ArticleModel>>((ref) async {
//   final articleApiService = ref.watch(articleApiServiceProvider);
//   return articleApiService.fetchArticles();
// });

//일단 ArticleApiService 프로바이더 생성

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:prac/models/others/article_model.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/provider/tweet/comment_control_provider.dart';
import 'package:prac/services/tweet/article_api_service.dart';

//일단 ArticleApiService 프로바이더 생성
final articleApiServiceProvider = Provider<ArticleApiService>((ref) {
  //클래스에서 필요로하는 인터셉터 디오 DI
  final dio = ref.watch(dioProvider);

  return ArticleApiService(dio: dio);
});

//그 다음에 FutureProvider를 통해서 fetchArticles진행

final articleApiProvider = FutureProvider<List<ArticleModel>>((ref) async {
  final articleApi = ref.watch(articleApiServiceProvider);
  return articleApi.fetchArticles();
});

//------------------------------------------------------------

final postArticleProvider = StateNotifierProvider((ref) {
  return PostArticleNotifier(ref.watch(articleApiServiceProvider), ref);
});

class PostArticleNotifier extends StateNotifier<AsyncValue<void>> {
  final ArticleApiService _api;
  final Ref _ref; //이 ref는 다른 provider 여기에서는 ArticleProvider
  //를 invalidate 하기 위해서 전달받음

  PostArticleNotifier(this._api, this._ref) : super(const AsyncData(null));

  // 게시글 작성 함수
  Future<void> postArticle(String content, CommentControl commentState) async {
    // 1) 간단한 프론트 유효성 검사
    if (content.trim().isEmpty) {
      state = AsyncError('내용이 비어 있습니다.', StackTrace.current);
      return;
    }

    // 2) 로딩 상태로 전환
    state = const AsyncLoading();

    try {
      // 3) 실제 API 호출
      await _api.postArticle(content, commentState);

      // 4) 기존 게시글 목록 새로고침 (타임라인 갱신)
      _ref.invalidate(articleApiProvider);

      // 5) 성공 상태로 변경
      state = const AsyncData(null);
    } catch (e, st) {
      // 6) 에러 상태로 변경
      state = AsyncError(e, st);
    }
  }
}
