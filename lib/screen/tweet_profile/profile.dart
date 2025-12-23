import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/provider/auth/login_provider.dart';
import 'package:prac/provider/others/profile_provider.dart';
import 'package:prac/provider/tweet/like_provider.dart';
import 'package:prac/widgets/tweet_list_tile.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final username = ref.read(loginProvider.notifier).getUsername();
    final profileAsync = ref.watch(profileProvider);

    //이건 ui 그리기용

    return profileAsync.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_outlined),
              ),
            ],
            backgroundColor: Colors.lightBlue,
          ),
          //최상단 사진 영역
          body: DefaultTabController(
            length: 6,
            child: Column(
              children: [
                SizedBox(
                  child: Image.network(
                    "https://picsum.photos/300/200",
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(),
                            TextButton(
                              onPressed: () {},
                              child: Text("프로필 설정하기"),
                            ),
                          ],
                        ),
                      ),
                      //닉네임
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(data.nickname)],
                      ),
                      //유저네임
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("@${data.username}")],
                      ),
                      SizedBox(height: 10),
                      //자기소개
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("${data.bio}")],
                      ),
                      SizedBox(height: 10),
                      //팔로잉, 팔로워
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${data.followingCount} 팔로잉"),
                          SizedBox(width: 10),
                          Text("${data.followerCount} 팔로워"),
                        ],
                      ),
                    ],
                  ),
                ),
                TabBar(
                  //탭바 스크롤 가능
                  isScrollable: true,

                  // 3️⃣ 스크롤 탭을 왼쪽 정렬로 고정 (Flutter 3.10+)
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: "게시물"),
                    Tab(text: "답글"),
                    Tab(text: "하이라이트"),
                    Tab(text: "아티클"),
                    Tab(text: "미디어"),
                    Tab(text: "마음에 들어요"),
                  ],
                ),
                SizedBox(height: 10),

                Expanded(
                  child: TabBarView(
                    children: [
                      InkWell(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: data.recentTweets.length,
                                itemBuilder: (context, index) {
                                  //이건 ui 그리기용
                                  final likeAsync = ref.watch(
                                    likeProvider(
                                      data.recentTweets[index].tweetId,
                                    ),
                                  );
                                  //이건 method 쓰기용
                                  final notifier = ref.read(
                                    likeProvider(
                                      data.recentTweets[index].tweetId,
                                    ).notifier,
                                  );
                                  return TweetListTile(
                                    nickname: data.recentTweets[index].nickname,
                                    username: data.recentTweets[index].username,
                                    tweetId: data.recentTweets[index].tweetId,
                                    content: data.recentTweets[index].content,
                                    retweetCount:
                                        data.recentTweets[index].retweetCount,
                                    // widget: widget,
                                    likeAsync: likeAsync,
                                    notifier: notifier,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text("게시글"),
                      Text("게시글"),
                      Text("게시글"),
                      Text("게시글"),
                      Text("게시글"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(child: Text("error : $error, st : $stackTrace")),
        );
      },
      loading: () {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
