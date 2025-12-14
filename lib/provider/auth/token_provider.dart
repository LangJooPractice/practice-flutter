import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//전역적으로 accessTokenProvider의 state를 정의합니다
//초기값이 null인 이유는 최초 구동시 token == null 을 하기 위함
final accessTokenProvider = StateProvider<String?>((ref) {
  return null;
});

//전역적으로 secureStorage에 접근할 수 있게 합니다.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage();
});
