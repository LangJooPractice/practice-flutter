import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/provider/article_provider.dart';
import 'package:prac/provider/comment_control_provider.dart';

class ArticlePost extends ConsumerStatefulWidget {
  const ArticlePost({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticlePostState();
}

class _ArticlePostState extends ConsumerState<ArticlePost> {
  //이 controller의 data값을 provider에 제공 이후 post
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postArticleProvider); //버튼 비활성화
    ref.listen(postArticleProvider, (prev, next) {
      //post Provider
      next.whenOrNull(
        data: (_) {
          if (prev?.isLoading == true) {
            context.pop();
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("error : $error")));
        },
      );
    });
    final commentState = ref.watch(commentControlProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true, //키보드와 함께 아래 부분 올라옴
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              postState.isLoading
                  ? null
                  : ref
                        .read(postArticleProvider.notifier)
                        .postArticle(textController.text);
            },
            child: postState.isLoading
                ? SizedBox(child: CircularProgressIndicator())
                : Text("게시하기"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CircleAvatar(),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: TextField(
                      controller: textController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "무슨 생각을 하고 있나요",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          title: ListTileControl(currentComment: commentState),
                          leading: LeadingIconControl(
                            currentComment: commentState,
                          ),
                          contentPadding: EdgeInsets.zero,

                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Consumer(
                                  builder: (context, ref, child) {
                                    final commentState = ref.watch(
                                      commentControlProvider,
                                    );
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        25,
                                        50,
                                        35,
                                        0,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "답글을 달 수 있는 사람",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            "이 게시물에 답글을 달 수 있는 사람을 선택하세요. 멘션된 사람은 언제든지 답글을 달 수 있습니다.",
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Text("모든 사람"),
                                                  leading:
                                                      commentState ==
                                                          CommentControl
                                                              .everyone
                                                      ? Icon(
                                                          Icons.public,
                                                          color: Colors.blue,
                                                        )
                                                      : Icon(Icons.public),
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                          commentControlProvider
                                                              .notifier,
                                                        )
                                                        .state = CommentControl
                                                        .everyone;

                                                    debugPrint(
                                                      commentState.toString(),
                                                    );
                                                  },
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,

                                                  title: Text("인증된 계정"),
                                                  leading:
                                                      commentState ==
                                                          CommentControl
                                                              .authenticated
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.blue,
                                                        )
                                                      : Icon(Icons.check),
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                          commentControlProvider
                                                              .notifier,
                                                        )
                                                        .state = CommentControl
                                                        .authenticated;
                                                  },
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,

                                                  title: Text("내가 팔로우 하는 계정"),
                                                  leading:
                                                      commentState ==
                                                          CommentControl
                                                              .following
                                                      ? Icon(
                                                          Icons.person,
                                                          color: Colors.blue,
                                                        )
                                                      : Icon(Icons.person),
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                          commentControlProvider
                                                              .notifier,
                                                        )
                                                        .state = CommentControl
                                                        .following;
                                                  },
                                                ),
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,

                                                  title: Text("내가 멘션하는 계정만"),
                                                  leading:
                                                      commentState ==
                                                          CommentControl
                                                              .mentioned
                                                      ? Icon(
                                                          Icons.alternate_email,
                                                          color: Colors.blue,
                                                        )
                                                      : Icon(
                                                          Icons.alternate_email,
                                                        ),
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                          commentControlProvider
                                                              .notifier,
                                                        )
                                                        .state = CommentControl
                                                        .mentioned;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.photo)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.gif)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.vertical_split_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on_sharp),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.question_mark_rounded),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeadingIconControl extends StatelessWidget {
  final CommentControl currentComment;

  const LeadingIconControl({super.key, required this.currentComment});

  @override
  Widget build(BuildContext context) {
    if (currentComment == CommentControl.everyone) {
      return Icon(Icons.public, color: Colors.blue);
    } else if (currentComment == CommentControl.authenticated) {
      return Icon(Icons.check, color: Colors.blue);
    } else if (currentComment == CommentControl.following) {
      return Icon(Icons.person, color: Colors.blue);
    } else {
      return Icon(Icons.alternate_email, color: Colors.blue);
    }
  }
}

class ListTileControl extends StatelessWidget {
  final CommentControl currentComment;
  const ListTileControl({super.key, required this.currentComment});

  @override
  Widget build(BuildContext context) {
    if (currentComment == CommentControl.everyone) {
      return Text("모든 사람이 답글을 달 수 있습니다.", style: TextStyle(color: Colors.blue));
    } else if (currentComment == CommentControl.authenticated) {
      return Text("인증된 계정만 답글을 쓸 수 있음", style: TextStyle(color: Colors.blue));
    } else if (currentComment == CommentControl.following) {
      return Text(
        "내가 팔로우 하는 계정은 답글을 쓸 수 있음",
        style: TextStyle(color: Colors.blue),
      );
    } else {
      return Text(
        "내가 멘션하는 계정만 답글을 쓸 수 있음",
        style: TextStyle(color: Colors.blue),
      );
    }
  }
}
