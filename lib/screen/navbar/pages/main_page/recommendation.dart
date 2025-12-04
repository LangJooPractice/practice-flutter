import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/article_model.dart';
import 'package:prac/provider/article_provider.dart';

//InkWell위젯을 사용하면 Inkwel child의 Row내의 children위젯들을 겹치기 할 수있다는 사실!

class Recommendation extends ConsumerStatefulWidget {
  const Recommendation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecommendationState();
}

class _RecommendationState extends ConsumerState<Recommendation> {
  @override
  Widget build(BuildContext context) {
    final articleAsync = ref.watch(ArticleProvider);
    return articleAsync.when(
      data: (articles) {
        return ListView.builder(
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
              icon: Icon(Icons.account_circle_outlined, size: 40),
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
