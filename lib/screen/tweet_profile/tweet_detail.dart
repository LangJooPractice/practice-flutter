// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prac/provider/tweet/like_provider.dart';
import 'package:prac/provider/tweet/tweet_provider.dart';

class TweetDetailScreen extends ConsumerStatefulWidget {
  final String tweetId;
  const TweetDetailScreen({super.key, required this.tweetId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TweetDetailScreenState();
}

class _TweetDetailScreenState extends ConsumerState<TweetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final tweetDetailAsync = ref.watch(tweetDetailProvider(widget.tweetId));

    //ui 상태 반환
    // final likeAsync = ref.watch();
    //method사용

    return Scaffold(
      appBar: AppBar(title: Text("게시하기", style: TextStyle(fontSize: 20))),
      body: tweetDetailAsync.when(
        error: (error, stackTrace) {
          return Center(child: Text("error : $error stacktrace : $stackTrace"));
        },
        data: (data) {
          //좋아요 ui상태
          final likeAsync = ref.watch(likeProvider(int.parse(widget.tweetId)));
          final likeNotifier = ref.read(
            likeProvider(int.parse(widget.tweetId)).notifier,
          );
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: [
                //상단 row - 프로필 이름 팔로우버튼 표시
                TweetTopRow(nickname: data.nickname, username: data.username),
                SizedBox(height: 15),
                //내용
                Content(content: data.content),
                SizedBox(height: 15),
                //생성 시간과 조회수 표현
                TimeViews(createdAt: data.createdAt),
                Divider(),
                //리트윗 인용 좋아요 북마크 버튼 표시
                RetweetEtcButtons(
                  retweetCount: data.retweetCount,
                  likeCount: data.likeCount,
                ),
                Divider(),
                //리트윗 좋아요 인용 버튼 row
                ButtonRow(likeAsync: likeAsync, likeNotifier: likeNotifier),
                Divider(),
              ],
            ),
          );
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//버튼있는 row
class ButtonRow extends StatelessWidget {
  final AsyncValue likeAsync;
  final LikeNotifier likeNotifier;
  const ButtonRow({
    super.key,
    required this.likeAsync,
    required this.likeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_bubble_outline),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.repeat_rounded),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            ),
          ),
          //좋아요
          IconButton(
            onPressed: () {
              likeNotifier.toggleLike();
            },
            icon: likeAsync.when(
              data: (data) {
                return data.liked
                    ? Icon(Icons.favorite, color: Colors.pink)
                    : Icon(Icons.favorite_border, color: Colors.black);
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
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                );
              },
            ),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            ),
          ),
        ],
      ),
    );
  }
}

//재게시물 인용 버튼, 좋아요 , 북마크 수
class RetweetEtcButtons extends StatelessWidget {
  final int retweetCount;
  final int likeCount;

  const RetweetEtcButtons({
    super.key,
    required this.retweetCount,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            //아래 3개의 설정값을 모두 해야 패딩이 최소로 됨
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            // foregroundColor: Colors.black,
          ),
          child: Row(
            children: [
              Text(
                retweetCount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(" 재게시물", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(width: 15),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            //아래 3개의 설정값을 모두 해야 패딩이 최소로 됨
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            // foregroundColor: Colors.black,
          ),
          child: Row(
            children: [
              Text(
                "10",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(" 인용", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(width: 15),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            //아래 3개의 설정값을 모두 해야 패딩이 최소로 됨
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            // foregroundColor: Colors.black,
          ),
          child: Row(
            children: [
              Text(
                likeCount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(" 마음에 들어요", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(width: 15),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            //아래 3개의 설정값을 모두 해야 패딩이 최소로 됨
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 축소
            // foregroundColor: Colors.black,
          ),
          child: Row(
            children: [
              Text(
                "5",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(" 북마크", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

//생성 시간과 조회수
class TimeViews extends StatelessWidget {
  final String createdAt;
  const TimeViews({super.key, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(createdAt),
        SizedBox(width: 20),
        Text("조회수"),
        Text("1.5억", style: TextStyle(fontWeight: FontWeight.bold)),
        Text("회"),
      ],
    );
  }
}

class Content extends StatelessWidget {
  final String content;
  const Content({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(content, style: TextStyle(fontSize: 20))],
    );
  }
}

//상단 Row - 프로필 이름 팔로우하기
class TweetTopRow extends StatelessWidget {
  final String nickname;
  final String username;
  const TweetTopRow({
    super.key,
    required this.nickname,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //프로필
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: CircleAvatar(),
        ),
        //유저 닉네임, 유저네임
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO : 이거 하나로 묶어서 누르면 profile로 이동하도록 설정
              Text(nickname),
              Text("@$username"),
            ],
          ),
        ),
        //팔로우하기 버튼
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SizedBox(
            height: 30,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              ),
              child: Text("팔로우하기", style: TextStyle(fontSize: 13)),
            ),
          ),
        ),
      ],
    );
  }
}
