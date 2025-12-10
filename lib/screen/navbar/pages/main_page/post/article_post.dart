import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticlePost extends ConsumerStatefulWidget {
  const ArticlePost({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArticlePostState();
}

class _ArticlePostState extends ConsumerState<ArticlePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post page")),
      body: Center(child: Text("This is post page")),
    );
  }
}
