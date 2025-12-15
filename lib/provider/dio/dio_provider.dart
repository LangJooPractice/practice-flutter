import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/provider/auth/token_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    //baseurl을 설정합니다.
    BaseOptions(
      contentType: "application/json",
      baseUrl: "http://localhost:8080/",
    ),
  );

  //onRequest시 accesstoken주입과
  //onResponse시 refreshToken으로 accessToken받기를 구현
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        //accessToken을 가져옵니다
        final accessToken = ref.read(accessTokenProvider.notifier).state;
        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }
        return handler.next(options);
      },
    ),
  );
  return dio;
});
