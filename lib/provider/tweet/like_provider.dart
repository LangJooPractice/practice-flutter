import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/others/article_model.dart';
import 'package:prac/models/others/like_state.dart';
import 'package:prac/models/others/tweet_detail_model.dart';
import 'package:prac/provider/dio/dio_provider.dart';
import 'package:prac/provider/tweet/tweet_provider.dart';
import 'package:prac/services/tweet/like_service.dart';

//ApiService를 반환하는 provider
final likeApiServiceProvider = Provider<LikeService>((ref) {
  //해당 부분에서 dio DI
  final dio = ref.read(dioProvider);
  //LikeService 반환
  return LikeService(dio: dio);
});

//---------------------------------------------------------------------------------------------------------
//main에서의 Like Provider

//family 프로바이더를 사용하는 이유는 각각의 Article마다 프로바이더를 제공하기 위함이며
//각각의 provider는 tweetId로 구분하나
//Notifier Provider내에서 article의 초기 상태값을 필요로 하므로
//ArticleModel 자체를 전달합니다.
final likeProvider = AsyncNotifierProvider.family<LikeNotifier, LikeState, int>(
  LikeNotifier.new,
);

class LikeNotifier extends AsyncNotifier<LikeState> {
  //이거 인수로 받는다는 뜻
  //위에서 선언한 fammily 의 인자를 아래 연관된 notifier의
  //생성자를 통해 저장할 수 있습니다.
  //https://riverpod.dev/docs/concepts2/family
  final int tweetId;
  LikeNotifier(this.tweetId);

  //초기값 설정
  //초기값은 family의 인자를 통해서 받은 ArticleModel의 인스턴스의
  // likeCount, likedByMe 값으로 이는 처음 article을 보여줄때의 값입니다.
  @override
  FutureOr<LikeState> build() async {
    final res = await ref
        .read(likeApiServiceProvider)
        .fetchLike(tweetId.toString());
    debugPrint(
      "빌드 안에서 : res.likeCount = ${res.likeCount}, res.liked = ${res.liked}",
    );

    // state = AsyncValue.data(
    //   LikeState(likeCount: res.likeCount, liked: res.liked),
    // );

    return LikeState(likeCount: res.likeCount, liked: res.liked);
  }

  // Future<void> _fetch() async {

  // }

  Future<void> toggleLike() async {
    //먼저 state를 로딩으로 바꾸어 ui상에서 loading일때
    //circular progress indicator 를 사용 할 수 있게 합니다.
    state = AsyncValue.loading();

    try {
      //일단 apiService의 toggleLike를 실행하여 res<LikeResponse>값을 받아오고
      final res = await ref.read(likeApiServiceProvider).toggleLike(tweetId);
      //그 후 state를 바꿔줍니다.
      //물론 AsyncNotifier이므로 이때의 상태는 AsyncValue.data 입니다.
      debugPrint(
        "after toggle likecount = ${res.likeCount}, liked = ${res.liked}",
      );
      state = AsyncValue.data(
        LikeState(likeCount: res.likeCount, liked: res.liked),
      );
    } catch (e, st) {
      //에러인경우 상태 변경
      state = AsyncValue.error(e, st);
    }
  }
}

//---------------------------------------------------------------------------------------------------------

//TweetDetail 창에서의 like provider

final likeTweetDetailProvider = AsyncNotifierProvider.autoDispose
    .family<LikeTweetDetailNotifier, LikeState, TweetDetailModel>(
      LikeTweetDetailNotifier.new,
    );

class LikeTweetDetailNotifier extends AsyncNotifier<LikeState> {
  //인수로 전달한 tweetDetailModel을 family 인자로 받습니다.
  final TweetDetailModel model;
  LikeTweetDetailNotifier(this.model);

  @override
  //해당 페이지의 tweetDetailModel의 인스턴스 값을 초기값으로 설정합니다.
  LikeState build() {
    return LikeState(likeCount: model.likeCount, liked: model.likedByMe);
  }

  Future<void> toggleLike() async {
    state = AsyncValue.loading();

    try {
      final response = await ref
          .read(likeApiServiceProvider)
          .toggleLike(model.tweetId);

      state = AsyncValue.data(
        LikeState(likeCount: response.likeCount, liked: response.liked),
      );
    } catch (e) {
      rethrow;
    }
  }
}
