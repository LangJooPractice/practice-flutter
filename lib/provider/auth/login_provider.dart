import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prac/models/auth/login_model.dart';
import 'package:prac/models/exception/login_excception.dart';
import 'package:prac/provider/auth/token_provider.dart';
import 'package:prac/services/auth/login_service.dart';

final loginApiServiceProvider = Provider<LoginApiService>((ref) {
  return LoginApiService(ref: ref);
});

final loginProvider = StateNotifierProvider<LoginNotifier, LoginModel>((ref) {
  return LoginNotifier(api: ref.watch(loginApiServiceProvider), ref: ref);
});

//LoginModel은 class내의 state가 됩니다.
class LoginNotifier extends StateNotifier<LoginModel> {
  final Ref ref;
  final LoginApiService api;

  LoginNotifier({required this.api, required this.ref}) : super(LoginModel());

  //새로운 모델 인스턴스를 생성하면서 email을 인자로 전달합니다.
  //state는 LoginModel의 type을 가집니다.
  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  //새로운 인스턴스를 생성하면서 password를 인자로 전달합니다.
  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  String getEmail() {
    return state.email;
  }

  String? getUsername() {
    return state.username;
  }

  Future<void> login(String email, String password) async {
    //일단 상태를 로딩으로 바꿉니다.
    state = state.copyWith(
      email: email,
      password: password,
      result: AsyncLoading(),
    );

    //-------------------------------------
    // if (email == "test@test.com" && password == "123456") {
    //   state = state.copyWith(
    //     email: email,
    //     password: password,
    //     result: AsyncData("success"),
    //   );
    // } else if (password != "123456") {
    //   state = state.copyWith(
    //     email: email,
    //     password: password,
    //     result: AsyncData("unauthorized"),
    //   );
    // }
    // //-------------------------------------
    try {
      LoginModel responseStatus = await api.requestLogin(email, password);

      //토큰 설정
      ref.read(accessTokenProvider.notifier).state = responseStatus.accessToken;

      //저장소 저장
      final storage = FlutterSecureStorage();
      storage.write(key: "accessToken", value: responseStatus.accessToken);
      storage.write(key: "refreshTo", value: responseStatus.refreshToken);

      //상태 업데이트
      state = state.copyWith(
        email: email,
        password: password,
        username: responseStatus.username,
        result: AsyncData("success"),
      );
    } on LoginUnauthorizedException {
      state = state.copyWith(result: AsyncData('unauthorized'));
    } on InternalServerException {
      state = state.copyWith(result: AsyncData("Internal Server Error"));
    } on LoginFail {
      state = state.copyWith(result: AsyncData("other"));
    }
  }
}
