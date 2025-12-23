import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/models/others/like_state.dart';
import 'package:prac/provider/tweet/like_provider.dart';
import 'package:prac/screen/navbar/pages/main_page/recommendation.dart';

class TweetListTile extends StatelessWidget {
  final String nickname;
  final String username;
  final int tweetId;

  final String content;
  final int? replyToTweetId;

  final int retweetCount;

  const TweetListTile({
    super.key,
    required this.nickname,
    required this.username,
    required this.tweetId,
    required this.content,
    this.replyToTweetId,
    required this.retweetCount,
    // required this.widget,
    required this.likeAsync,
    required this.notifier,
  });

  // final ArticleContainer widget;
  final AsyncValue<LikeState>? likeAsync;
  final LikeNotifier? notifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          context.push('/tweet/$tweetId');
        },
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
                      Text(nickname),
                      Text("@$username"),
                      Text(" tweetId : $tweetId"),
                    ],
                  ),
                  SizedBox(height: 5),
                  //게시글 본문을 출력합니다.
                  Row(children: [Text(content)]),
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
                              Text("$replyToTweetId"),
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
                              Text("${retweetCount.toInt()}"),
                            ],
                          ),
                        ),
                      ),
                      //좋아요 버튼
                      Expanded(
                        child: likeAsync!.when(
                          //data의 타입은 LikeState입니다.
                          data: (data) {
                            return InkWell(
                              onTap: () {
                                notifier!.toggleLike();
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
                      //북마크 통계 공유 버튼container
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
