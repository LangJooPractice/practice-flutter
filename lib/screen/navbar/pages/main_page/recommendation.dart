// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:prac/models/others/article_model.dart';
import 'package:prac/models/others/like_state.dart';
import 'package:prac/provider/others/scroll_provider.dart';
import 'package:prac/provider/tweet/article_provider.dart';
import 'package:prac/provider/tweet/like_provider.dart';
import 'package:prac/widgets/tweet_list_tile.dart';

//InkWell위젯을 사용하면 Inkwel child의 Row내의 children위젯들을 겹치기 할 수있다는 사실!

class Recommendation extends ConsumerStatefulWidget {
  const Recommendation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecommendationState();
}

class _RecommendationState extends ConsumerState<Recommendation> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ref.read(
      scrollControllerProvider,
    ); //스크롤 컨트롤러로 스크롤 위치 유지, 무한 스크롤 등의 기능을 함
    final articleAsync = ref.watch(
      articleApiProvider,
    ); //백으로부터 article의 정보를 가져와 리스트뷰에 뿌려줌

    return articleAsync.when(
      data: (articles) {
        return ListView.builder(
          controller: scrollController,
          itemCount: articles.length, //받아온 articles객체의 개수
          itemBuilder: (context, index) {
            final article = articles[index];
            // debugPrint(
            //   "article 뿌릴때 : likecount = ${article.likeCount}, liked = ${article.likedByMe}",
            // );
            return ArticleContainer(articles: article);
          },
        );
      },
      error: (error, stackTrace) {
        return Text("$stackTrace, $error");
      },
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class ArticleContainer extends ConsumerStatefulWidget {
  final ArticleModel articles;
  const ArticleContainer({super.key, required this.articles});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ArticleContainerState();
}

class _ArticleContainerState extends ConsumerState<ArticleContainer> {
  @override
  Widget build(BuildContext context) {
    //이 안애 family provider를 정의함으로서 article각각에 대해서
    //provider를 설정 할 수 있습니다.

    //이건 ui 그리기용
    final likeAsync = ref.watch(likeProvider(widget.articles.tweetId));
    //이건 method 쓰기용
    final notifier = ref.read(likeProvider(widget.articles.tweetId).notifier);

    //article 받아서 초기상태 구현하고 -> api도 보내면 되겟네?
    //그럼 일단 response 모델을 만들어
    //그리고 state를 저장할 likestate 모델도 만들어
    //근데 article 마다 provider가 있어야 되네? -> 그럼 family 쓰면 될듯?

    return TweetListTile(
      // widget: widget,
      likeAsync: likeAsync,
      notifier: notifier,
      nickname: widget.articles.nickname,
      username: widget.articles.username,
      tweetId: widget.articles.tweetId,
      content: widget.articles.content,
      replyToTweetId: widget.articles.replyToTweetId,
      retweetCount: widget.articles.retweetCount,
    );
  }
}
