import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostFollowScreen extends ConsumerStatefulWidget {
  const PostFollowScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostFollowScreenState();
}

class _PostFollowScreenState extends ConsumerState<PostFollowScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("팔로우 중 페이지 입니다."));
  }
}
