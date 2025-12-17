// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prac/models/auth/login_model.dart';
import 'package:prac/models/exception/login_excception.dart';

class LoginApiService {
  final Ref ref;
  LoginApiService({required this.ref});

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8080",
      validateStatus: (status) {
        return status != null && status < 600;
      },
    ),
  );

  Future<LoginModel> requestLogin(String email, String password) async {
    try {
      //서버로 로그인요청을 보냅니다. 포함사항 : 아이디, 비밀번호
      final request = await dio.post(
        "/api/users/login",
        data: {"loginId": email, "password": password},
      );
      log(request.statusCode!);

      //request를 받아오고 그 응답의 data를 reponse 변수에 저장합니다.
      final response = request.data;

      //성공한경우 각각의 토큰과 username을 변수에 저장하고 이를 storage에 보관합니다.
      if (request.statusCode == 200) {
        return LoginModel.fromJson(response);

        // final accessToken = response['accessToken'];
        // final refreshToken = response['refreshToken'];
        // final username = response['username'];
        // final tokenType = response['tokenType'];

        // await storage.write(key: "accesstoken", value: accessToken);
        // await storage.write(key: "refreshtoken", value: refreshToken);
        // await storage.write(key: "tokentype", value: tokenType);
        // await storage.write(key: "username", value: username);

        // ref.read(accessTokenProvider.notifier).state = accessToken;
      }
      //이메일정보 또는 비밀번호가 잘못된경우
      else if (request.statusCode == 401) {
        throw LoginUnauthorizedException();
      }
      //서버 내부 오류인경우
      else if (request.statusCode == 500) {
        //error code 500인경우 해당 계정이 존재하지않음
        throw InternalServerException();
      }
      //기타 오류인경우
      else {
        throw LoginFail();
      }
      //request status code 400 이메일 또는 비밀번호 형식 오류는 모바일에서 validate
    } catch (e) {
      rethrow;
    }
  }
}
