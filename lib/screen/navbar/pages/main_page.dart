import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/screen/navbar/pages/main_page/post_follow_screen.dart';
import 'package:prac/screen/navbar/pages/main_page/recommendation.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //TabBar상위 위젯으로 controller가 있어야된다는 사실
      length: 2,
      child: Column(
        children: [
          TabBar(tabs: [Text("추천"), Text("팔로우 중")]),
          Expanded(
            child: TabBarView(children: [Recommendation(), PostFollowScreen()]),
          ),
        ],
      ),
    );
  }
}
