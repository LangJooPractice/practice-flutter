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
      _ArticleContainerState();
}

class _ArticleContainerState extends ConsumerState<ArticleContainer> {
  @override
  Widget build(BuildContext context) {
    //이 안애 family provider를 정의함으로서 article각각에 대해서
    //provider를 설정 할 수 있습니다.

    //이건 ui 그리기용
    final likeAsync = ref.watch(likeProvider(widget.articles));
    //이건 method 쓰기용
    final notifier = ref.read(likeProvider(widget.articles).notifier);

    //article 받아서 초기상태 구현하고 -> api도 보내면 되겟네?
    //그럼 일단 response 모델을 만들어
    //그리고 state를 저장할 likestate 모델도 만들어
    //근데 article 마다 provider가 있어야 되네? -> 그럼 family 쓰면 될듯?

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
                      Expanded(
                        child: likeAsync.when(
                          //data의 타입은 LikeState입니다.
                          data: (data) {
                            return InkWell(
                              onTap: () {
                                notifier.toggleLike();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //response로 받은 isLiked값에 따라 버튼 변경
                                  data.liked
                                      ? Icon(Icons.favorite, color: Colors.pink)
                                      : Icon(Icons.favorite_border_outlined),
                                  SizedBox(width: 2),
                                  Text("${data.likeCount}"),
                                ],
                              ),
                            );
                          },
                          error: (error, stackTrace) {
                            return Icon(Icons.error);
                          },
                          loading: () {
                            return Row(
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
                            );
                          },
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
