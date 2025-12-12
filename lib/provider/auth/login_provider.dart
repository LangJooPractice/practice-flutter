import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:prac/models/auth/login_model.dart';
import 'package:prac/services/login_service.dart';

final loginApiServiceProvider = Provider<LoginApiService>((ref) {
  return LoginApiService();
});

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginModel>((ref) {
      return LoginNotifier(api: ref.watch(loginApiServiceProvider));
    });

//LoginModel은 class내의 state가 됩니다.
class LoginNotifier extends StateNotifier<LoginModel> {
  final LoginApiService api;

  LoginNotifier({required this.api}) : super(LoginModel());

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

  Future<void> login(String email, String password) async {
    //일단 상태를 로딩으로 바꿉니다.
    state.copyWith(email: email, password: password, result: AsyncLoading());

    //-------------------------------------
    if (email == "test@test.com" && password == "123456") {
      state = state.copyWith(
        email: email,
        password: password,
        result: AsyncData("success"),
      );
    } else if (password != "123456") {
      state = state.copyWith(
        email: email,
        password: password,
        result: AsyncData("unauthorized"),
      );
    }
    //-------------------------------------
    try {
      String responseStatus = await api.requestLogin(email, password);
      if (responseStatus == "success") {
        state = state.copyWith(
          email: email,
          password: password,
          result: AsyncData("success"),
        );
      } else if (responseStatus == "unauthorized") {
        state = state.copyWith(result: AsyncData("unauthorized"));
      } else if (responseStatus == "Internal Server Error") {
        state = state.copyWith(result: AsyncData("Internal Server Error"));
      } else if (responseStatus == "other") {
        state = state.copyWith(result: AsyncData('other'));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
