import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/screen/auth/login_enter_id.dart';
import 'package:prac/screen/auth/login_enter_pw.dart';
import 'package:prac/screen/auth/login_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/login-enter-id',
        builder: (context, state) {
          return LoginEnterId();
        },
      ),
      GoRoute(
        path: '/login-enter-pw',
        builder: (context, state) {
          return LoginEnterPw();
        },
      ),
    ],
  );
  return router;
});
