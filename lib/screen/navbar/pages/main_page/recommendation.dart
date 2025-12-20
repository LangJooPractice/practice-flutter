import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/models/others/article_model.dart';
import 'package:prac/provider/tweet/article_provider.dart';
import 'package:prac/provider/others/scroll_provider.dart';
import 'package:prac/provider/tweet/like_provider.dart';

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
      _ArticleContainerState(articles.tweetId);
}

class _ArticleContainerState extends ConsumerState<ArticleContainer> {
  final int tweetId;

  _ArticleContainerState(this.tweetId);

  @override
  Widget build(BuildContext context) {
    final likeAsync = ref.watch(likeProvider(widget.articles));
    final notifier = ref.read(likeProvider(widget.articles).notifier);
    return InkWell(
      onTap: () {
        context.push('/tweet/${widget.articles.tweetId}');
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: ClipOval(
                child: Image.network(
                  width: 40,
                  height: 40,
                  "https://loremflickr.com/1795/1444?lock=233092803421850",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //닉네임과 아이디를 출력합니다.
                  Row(
                    children: [
                      Text(widget.articles.nickname),
                      Text("@${widget.articles.nickname}"),
                      Text("tweetId : ${widget.articles.tweetId}"),
                    ],
                  ),
                  SizedBox(height: 5),
                  //게시글 본문을 출력합니다.
                  Row(children: [Text(widget.articles.content)]),
                  SizedBox(height: 10),
                  //답글 창 버튼입니다
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.chat_bubble_outline),
                              SizedBox(width: 2),
                              Text("${widget.articles.replyToTweetId}"),
                            ],
                          ),
                        ),
                      ),
                      //리트윗 버튼
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.repeat_rounded),
                              SizedBox(width: 2),
                              Text("${widget.articles.retweetCount.toInt()}"),
                            ],
                          ),
                        ),
                      ),
                      //좋아요 버튼
                      // 좋아요 버튼
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            notifier.toggleLike();
                          },
                          child: likeAsync.when(
                            data: (likeState) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                likeState.isLiked
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                      ),
                                const SizedBox(width: 2),
                                Text('${likeState.likeCount}'),
                              ],
                            ),
                            loading: () => const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.favorite_border_outlined),
                                SizedBox(width: 2),
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            ),
                            error: (_, __) => const Icon(Icons.error),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.bar_chart_rounded),
                                  Text('10'),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.bookmark_border_outlined),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.share_outlined),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
