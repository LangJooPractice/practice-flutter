import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:prac/services/register_service.dart';

final registerApiServiceProvider = Provider<RegisterApiService>((ref) {
  return RegisterApiService();
});

//StateNotifierProvider는 <NotifierType,StateType>을 가지며
//NotifierType은 상태변화 로직을 포함하는 class이다.
//AsyncValue<>는 위로인해 변화한 상태의 부모이다
//즉 NotifierType를 통해 로직변화가 이루어지고 이를통한 상태변화의 결과가 AsyncValue<>
final postRegisterProvider =
    StateNotifierProvider<RegisterProvider, AsyncValue<String?>>((ref) {
      return RegisterProvider(api: ref.watch(registerApiServiceProvider));
    });

class RegisterProvider extends StateNotifier<AsyncValue<String?>> {
  final RegisterApiService api;

  RegisterProvider({required this.api}) : super(const AsyncData(null));
  Future<String> postRegister(String email, String password) async {
    //일단 로딩으로 바꿔
    state = AsyncLoading();
    //테스트 코드
    //---------------------------------------
    if (email == "test@test.com" && password == "123456") {
      state = AsyncData("success");
      return "success";
    }
    //---------------------------------------

    //2차 백으로 request 전달
    try {
      String responseStatus = await api.requestRegister(email, password);

      //그리고 상태를 AsyncData로 바꿔
      //
      //상태가 Success 즉 회원가입상에서 중복이 없는경우
      if (responseStatus == "success") {
        state = AsyncData("success");
        return responseStatus; //return success
      }
      //
      //상태가 fail 즉 회원가입상에서 중복인경우
      else if (responseStatus == "fail") {
        state = AsyncData("fail");
        return responseStatus;
      }
      //
      //그 외의 경우 즉 통신상 문제인경우
      else {
        state = AsyncData("other");
        return responseStatus;
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      throw Exception("error : $e");
    }
  }
}
