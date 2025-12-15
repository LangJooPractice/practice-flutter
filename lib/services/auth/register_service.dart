import 'dart:math';

import 'package:dio/dio.dart';

class RegisterApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8080",
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  //register POST
  Future<String> requestRegister(
    String email,
    String password,
    String nickname,
    String username,
  ) async {
    try {
      final request = await dio.post(
        "/api/users/register",
        data: {
          "loginId": email,
          "username": username,
          "nickname": nickname,
          "password": password,
        },
        // options: Options(headers: {'Content-type': 'application/json'}),
      );
      log(request.statusCode!);

      // final response = request.data; //백에서 받아오는 성공/실패 json
      //성공이면 success 반환
      if (request.statusCode == 201) {
        return "success";
      }
      //중복인 경우 statuscode 409 반환
      else if (request.statusCode == 409) {
        return "redundant";
      }
      //이외의 오류인경우 오류코드 : 오류메세지 반환
      else {
        return "${request.statusCode} : ${request.statusMessage}";
      }
    } catch (e) {
      throw Exception("오류 발생 : $e");
    }
  }
}
