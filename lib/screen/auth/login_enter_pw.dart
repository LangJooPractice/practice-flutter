import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/models/auth/login_model.dart';
import 'package:prac/provider/auth/login_provider.dart';

class LoginEnterPw extends ConsumerStatefulWidget {
  const LoginEnterPw({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginEnterPwState();
}

class _LoginEnterPwState extends ConsumerState<LoginEnterPw> {
  bool obscure = true;
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final pwKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    //전에 입력한 이메일을 가져옵니다.
    idController.text = loginState.email;
    ref.listen<LoginModel>(loginProvider, (prev, next) {
      next.result.when(
        data: (value) {
          if (value == "success") {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("로그인 되었습니다.")));
            context.go('/main');
          } else if (value == "unauthorized") {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("입력한 정보가 잘못되었습니다.")));
          } else if (value == "Internal Server Error") {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("서버 내부오류가 발생하였습니다.")));
          } else if (value == "other") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("기타 오류가 발생했습니다. 다시 시도해주세요.")),
            );
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("오류가 발생했습니다 : $error")));
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: Icon(Icons.anchor)),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  Center(child: Text("비밀번호를 입력하세요")),
                  SizedBox(height: 20),
                  Form(
                    key: pwKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: idController,
                          decoration: InputDecoration(
                            hintText: idController.text,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "비밀번호를 입력하세요";
                            } else if (value.length < 6) {
                              return "비밀번호는 최소 6자 이상이어야 합니다.";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: obscure,
                          obscuringCharacter: '*',

                          controller: pwController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: Icon(
                                obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: "비밀번호",
                          ),
                        ),
                      ],
                    ),
                  ),
                  // TextField(
                  //   controller: idController,
                  //   decoration: InputDecoration(
                  //     hintText: idController.text,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // TextField(
                  //   obscureText: obscure,
                  //   obscuringCharacter: '*',

                  //   controller: pwController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     suffixIcon: IconButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           obscure = !obscure;
                  //         });
                  //       },
                  //       icon: Icon(
                  //         obscure ? Icons.visibility_off : Icons.visibility,
                  //       ),
                  //     ),
                  //     hintText: "비밀번호",
                  //   ),
                  // ),
                ],
              ),
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("비밀번호를 잊으셨나요?"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (pwKey.currentState!.validate()) {
                          //Login을 진행합니다.
                          ref
                              .read(loginProvider.notifier)
                              .login(idController.text, pwController.text);
                        }
                      },
                      child: Text("다음"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
