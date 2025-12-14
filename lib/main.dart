import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/provider/auth/token_provider.dart';
import 'package:prac/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  //초기상태를 설정합니다.
  void initState() {
    super.initState();

    //서버로부터 토큰을 발급받기 전까지 임의로 생성 저장합니다.
    loadAccessToken();
  }

  Future<void> loadAccessToken() async {
    //프로바이더를 통해 storage에 접근할 수 있게 합니다.
    final storage = ref.read(secureStorageProvider);
    //토큰의 값을 임의로 생성 저장합니다
    final token = await storage.read(key: 'accessToken');

    //이후 accessToken을 관리하는 프로바이더의 상태를 저장합니다.
    ref.read(accessTokenProvider.notifier).state = token;
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(routerConfig: router, title: 'prac');
  }
}
