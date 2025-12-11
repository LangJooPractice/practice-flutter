import 'package:dio/dio.dart';

class RegisterApiService {
  final Dio dio = Dio(
    BaseOptions(baseUrl: "https://693108ef11a8738467ccfc6c.mockapi.io/"),
  );

  //register POST
  Future<String> requestRegister(String email, String password) async {
    try {
      final request = await dio.post(
        "register",
        data: {"email": email, "password": password},
      );

      final response = request.data; //백에서 받아오는 성공/실패 json
      //성공이면 success 반환
      if (response.json["success"]) {
        return "success";
      }
      //중복인 경우 fail 반환
      else if (response.json["fail"]) {
        return "fail";
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
