import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/provider/auth/register_provider.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    //Form 위젯 밖에서(버튼) form.validate()을 하기 위해서 key를 사용하여 formState에 접근
    final formKey = GlobalKey<FormState>();
    //--------------------------------------------
    //이건 회원가입 페이지에서 버튼등을 누를때 사용
    final registerState = ref.watch(postRegisterProvider);

    //------------------------------------------
    //회원가입 이후 서버의 응답에 따라 그 응답값을 listen 하고
    //값에 따라 페이지 로직을 결정함
    //success 이면 pop, fail/other이면 오류 메세지 출력
    ref.listen<AsyncValue<String?>>(postRegisterProvider, (prev, next) {
      next.when(
        data: (value) {
          if (value == "success") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("회원가입이 성공했습니다. 잠시후 로그인페이지로 이동합니다."),
                duration: Duration(milliseconds: 3000),
              ),
            );
            Future.delayed(Duration(seconds: 3)).then((_) {
              context.pop();
            });
          } else if (value == "fail") {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("중복되는 이메일입니다. 다시 확인하세요.")));
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("알수 없는 오류가 발생했습니다.")));
          }
        },
        error: (err, st) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("오류가 발생했습니다 : $err")));
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: Icon(Icons.anchor), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: [
            Center(child: Text("계정을 생성하세요")),

            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: registerEmailController,
                    decoration: InputDecoration(hintText: "이메일"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "이메일을 입력하세요,";
                      } else if (!isValidEmail(value)) {
                        return "올바른 이메일 형식을 입력하세요.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: isObscure,
                    controller: registerPasswordController,
                    decoration: InputDecoration(
                      hintText: "비밀번호는 최소 6자리여야 합니다.",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "비밀번호를 입력하세요,";
                      } else if (value.length < 5) {
                        return "비밀번호는 최소 6자리여야 합니다.";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  //처음 누른 경우 당연히 isLoading이 아님 -> ref.read실행
                  //ref.read를 사용하는 이유 -> notifier를 이용해서 postRegister를 사용하기 위해
                  //postRegister의 parameter값을 controller를 통해 전달하고
                  //서버로 그 값을 전송함 이후 로직은 서버의 응답으로부터 ASyncValue가 변하고
                  //그걸 위의 ref.listen이 감지하여 상태에 따른 화면 구현
                  onPressed: registerState.isLoading
                      ? null
                      : () async {
                          try {
                            await ref
                                .read(postRegisterProvider.notifier)
                                .postRegister(
                                  registerEmailController.text,
                                  registerPasswordController.text,
                                );
                          } catch (e) {
                            throw Exception(e);
                          }
                        },
                  //누른경우 그 직후 registerState가 AsyncLoading으로 변하므로 버퍼가 돌고
                  //이후 응답을 받으면 AsyncData값을 가지므로 다시 버튼을 활성화 함
                  child: registerState.isLoading
                      ? CircularProgressIndicator()
                      : Text("게시하기"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//그냥 복붙함 뭔뜻인지 모름
bool isValidEmail(String value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value);
}
