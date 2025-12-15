import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginModel {
  String email;
  String password;
  AsyncValue<String?> result;

  LoginModel({
    this.email = "",
    this.password = "",
    this.result = const AsyncData(null),
  });

  LoginModel copyWith({
    String? email,
    String? password,
    AsyncValue<String?>? result,
  }) {
    //return값은 LoginModel 입니다.
    //대신 입력 parameter가 null이 아닌경우 ??좌측을 null인경우 ??우측을 할당합니다.
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      result: result ?? this.result,
    );
  }
}
