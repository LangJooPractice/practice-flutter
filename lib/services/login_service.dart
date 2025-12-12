import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "https://693108ef11a8738467ccfc6c.mockapi.io/"),
  );

  Future<String> requestLogin(String email, String password) async {
    final storage = FlutterSecureStorage();
    try {
      //서버로 로그인요청을 보냅니다. 포함사항 : 아이디, 비밀번호
      final request = await dio.post(
        "api/auth/login",
        data: {"loginId": email, "password ": password},
      );

      //request를 받아오고 그 응답의 data를 reponse 변수에 저장합니다.
      final response = request.data;
      //성공한경우 각각의 토큰과 username을 변수에 저장하고 이를 storage에 보관합니다.
      if (request.statusCode == 200) {
        final accessToken = response['accesstoken'];
        final refreshToken = response['refreshtoken'];
        final username = response['username'];
        final tokenType = response['tokenType'];

        await storage.write(key: "accesstoken", value: accessToken);
        await storage.write(key: "refreshtoken", value: refreshToken);
        await storage.write(key: "tokentype", value: tokenType);
        await storage.write(key: "username", value: username);

        return "success";
      }
      //이메일정보 또는 비밀번호가 잘못된경우
      else if (request.statusCode == 401) {
        return "unauthorized"; //TODO : response의 error값에 따라 바꿔주는게 나을듯
      }
      //서버 내부 오류인경우
      else if (request.statusCode == 500) {
        return "Internal Server Error";
      }
      //기타 오류인경우
      else {
        return "other";
      }
      //request status code 400 이메일 또는 비밀번호 형식 오류는 모바일에서 validate
    } catch (e) {
      throw Exception(e);
    }
  }
}
