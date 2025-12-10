import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainShell extends ConsumerStatefulWidget {
  final Widget child;
  const MainShell(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  //dial 이 열려있는지 닫혀있는지 봄.
  final isOpenProvider = StateProvider<bool>((ref) {
    return false;
  });

  // final ValueNotifier<bool> isFabOpen = ValueNotifier(false);
  // Widget FabButton() {
  //   return IconButton(
  //     onPressed: () {
  //       context.go('/post');
  //     },
  //     icon: Icon(Icons.close),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    int currentIndex = 0;
    if (location.startsWith('/main')) {
      currentIndex = 0;
    } else if (location.startsWith('/search')) {
      currentIndex = 1;
    } else if (location.startsWith('/grok')) {
      currentIndex = 2;
    } else if (location.startsWith('/notification')) {
      currentIndex = 3;
    } else if (location.startsWith("/message")) {
      currentIndex = 4;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Icon(Icons.anchor),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.account_circle_outlined),
            );
          },
        ),
      ),
      body: widget.child,
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            label: '홈',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.search, color: Colors.black, weight: 300),
            activeIcon: Icon(Symbols.search, weight: 1000),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exposure_zero, color: Colors.black),
            activeIcon: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Icon(Icons.exposure_zero, color: Colors.white),
            ),
            label: 'Grok',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            activeIcon: Icon(Icons.notifications),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_post_office_outlined, color: Colors.black),
            activeIcon: Icon(
              Icons.local_post_office_rounded,
              color: Colors.black,
            ),
            label: '메세지',
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            context.go('/main');
          } else if (value == 1) {
            context.go('/search');
          } else if (value == 2) {
            context.go('/grok');
          } else if (value == 3) {
            context.go('/notification');
          } else if (value == 4) {
            context.go('/message');
          }
        },
      ),

      //flutter_speed_dial 을 이용한 floating action button구현
      floatingActionButton: SpeedDial(
        dialRoot: (context, isOpen, toggleChildren) {
          //isOpen == False 인 경우 즉 처음 버튼을 누르는 경우 => dial 열기 기능 동작
          return FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              if (!isOpen) {
                // 1. 닫힌 상태 → 메뉴 열기만
                debugPrint('FAB if (open == false)');
                toggleChildren(); // ← 이게 열기
              } else {
                // 2. 열린 상태 → 액션 실행 + 메뉴 닫기
                debugPrint('FAB else (open == true)');
                context.push('/post');
                toggleChildren(); // ← 이게 닫기
              }
            },
            child: Icon(isOpen ? Icons.post_add : Icons.close),
          );
        },
        children: [
          SpeedDialChild(
            child: Icon(Icons.photo_size_select_actual_rounded),
            label: "사진",
            onTap: () {
              context.push('/post');
            },
          ),
          SpeedDialChild(child: Icon(Icons.mic), label: "스페이스"),
          SpeedDialChild(child: Icon(Icons.video_call), label: "생방송 시작하기"),
        ],
        child: Icon(Icons.add),
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DrawerHeader(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [CircleAvatar()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    context.push('/profile');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("사용자 이름"), Text("@사용자 아이디")],
                  ),
                ),
              ],
            ),
            Row(children: [Text("0 팔로잉  0 팔로워")]),
            SizedBox(height: 10),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            DrawerMenuListView(),
            Divider(color: Colors.grey),
            ExpansionTile(
              title: Text("설정 & 지원"),
              shape: Border(top: BorderSide.none),
              children: [
                SizedBox(
                  height: 40,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("설정 및 개인정보"),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListTile(
                    leading: Icon(Icons.question_mark_sharp),
                    title: Text("고객센터"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.wb_sunny_outlined),
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

class DrawerMenuListView extends StatelessWidget {
  const DrawerMenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,

      children: [
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("프로필"),
            onTap: () {
              context.push('/profile');
            },
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.close_outlined),
            title: Text("Premium"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.chat_bubble_outline_sharp),
            title: Text('Chat'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.people),
            title: Text("커뮤니티"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.bookmark),
            title: Text("북마크"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.list),
            title: Text("리스트"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.mic),
            title: Text("스페이스"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        SizedBox(
          height: 47,
          child: ListTile(
            leading: Icon(Icons.attach_money_outlined),
            title: Text("수익 창출"),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
