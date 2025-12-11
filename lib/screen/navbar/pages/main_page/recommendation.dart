import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/article_model.dart';
import 'package:prac/provider/article_provider.dart';
import 'package:prac/provider/scroll_provider.dart';

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
      ArticleProvider,
    ); //백으로부터 article의 정보를 가져와 리스트뷰에 뿌려줌
    return articleAsync.when(
      data: (articles) {
        return ListView.builder(
          controller: scrollController,
          itemCount: articles.length,
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
    return InkWell(
      onTap: () {},
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
                  widget.articles.profile_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(widget.articles.nickname),
                      Text("@${widget.articles.nickname_id}"),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(children: [Text(widget.articles.article_string)]),
                  SizedBox(height: 10),
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
                              Text("${widget.articles.comment_num.toInt()}"),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.repeat_rounded),
                              SizedBox(width: 2),
                              Text("${widget.articles.retweet_num.toInt()}"),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.favorite_border_outlined),
                              SizedBox(width: 2),
                              Text("${widget.articles.favorite_num.toInt()}"),
                            ],
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
                                  Text('${widget.articles.statistics.toInt()}'),
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
