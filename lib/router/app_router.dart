import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/screen/auth/login_enter_id.dart';
import 'package:prac/screen/auth/login_enter_pw.dart';
import 'package:prac/screen/auth/login_screen.dart';
import 'package:prac/screen/navbar/pages/grok.dart';
import 'package:prac/screen/navbar/pages/main_page.dart';
import 'package:prac/screen/navbar/pages/main_page/post/article_post.dart';
import 'package:prac/screen/navbar/profile.dart';
import 'package:prac/screen/navbar/shell/main_shell.dart';
import 'package:prac/screen/navbar/pages/message.dart';
import 'package:prac/screen/navbar/pages/notification.dart';
import 'package:prac/screen/navbar/pages/search.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      // ============================
      // 로그인 그룹 (ShellRoute 바깥)
      // ============================
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/login-enter-id',
        builder: (context, state) => LoginEnterId(),
      ),
      GoRoute(
        path: '/login-enter-pw',
        builder: (context, state) => LoginEnterPw(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          return Profile();
        },
      ),
      GoRoute(
        path: '/post',
        builder: (context, state) {
          return ArticlePost();
        },
      ),

      // ============================
      // 메인 그룹 (ShellRoute 안)
      // ============================
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child); // ← MainShell이 공통 레이아웃
        },
        routes: [
          GoRoute(path: '/main', builder: (context, state) => MainPage()),
          GoRoute(path: '/search', builder: (context, state) => Search()),
          GoRoute(path: '/grok', builder: (context, state) => Grok()),
          GoRoute(
            path: '/notification',
            builder: (context, state) => Notification(),
          ),
          GoRoute(path: '/message', builder: (context, state) => Message()),
        ],
      ),
    ],
  );

  return router;
});
