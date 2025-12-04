import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainShell extends ConsumerStatefulWidget {
  final Widget child;
  const MainShell(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
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
