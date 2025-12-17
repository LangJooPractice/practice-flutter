import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginModel {
  String email;
  String password;
  AsyncValue<String?> result;

  String accessToken;
  String refreshToken;
  int status;

  String? username;

  LoginModel({
    this.email = "",
    this.password = "",
    this.result = const AsyncData(null),
    this.accessToken = "",
    this.refreshToken = "",
    this.status = 500,
    this.username = "",
  });

  //로그인 정보 입력창에서 이메일 비밀번호 입력
  LoginModel copyWith({
    String? email,
    String? password,
    AsyncValue<String?>? result,
    int? status,
    String? username,
  }) {
    //return값은 LoginModel 입니다.
    //대신 입력 parameter가 null이 아닌경우 ??좌측을 null인경우 ??우측을 할당합니다.
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
      result: result ?? this.result,
      status: status ?? this.status,
      username: username ?? this.username,
    );
  }

  // response의 토큰값과 usename을 파싱합니다.
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json["accessToken"],
      refreshToken: json['refreshToken'],
      username: json['username'],
    );
  }
}
