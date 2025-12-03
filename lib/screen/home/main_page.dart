import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.anchor),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
      ),
      body: Center(child: Text("메인페이지 입니다.")),
      drawer: MainDrawer(),
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
