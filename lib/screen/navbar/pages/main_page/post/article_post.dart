import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/provider/article_provider.dart';

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
                          contentPadding: EdgeInsets.zero,

                          onTap: () {},
                          title: Text("모든 사람이 답글을 달 수 있습니다."),
                          leading: Icon(Icons.public),
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
