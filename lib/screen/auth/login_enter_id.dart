import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prac/models/auth/login_model.dart';
import 'package:prac/provider/auth/login_provider.dart';

class LoginEnterId extends ConsumerStatefulWidget {
  const LoginEnterId({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginEnterIdState();
}

class _LoginEnterIdState extends ConsumerState<LoginEnterId> {
  final idController = TextEditingController();
  final idFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //다음버튼을 누를때 email값을 전달하는 역할을 하도록 provider를 구독합니다.
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: Icon(Icons.anchor)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(10, 0, 10, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      '시작하려면 먼저 휴대폰 번호, 이메일 \n'
                      '또는 사용자 아이디를 입력하세요.',
                    ),
                  ),
                  Form(
                    key: idFormKey,
                    child: TextFormField(
                      controller: idController,
                      decoration: InputDecoration(
                        hintText: "휴대폰 번호, 이메일 주소 또는 사용자 아이디",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      //여기서 어차피 email이 validate되기때문에 차기만 한다면 다음 toggle true
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "이메일을 입력하세요.";
                        } else if (!isValidEmail(value)) {
                          return "올바른 이메일 형식을 입력하세요.";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  // TextField(
                  //   controller: idController,
                  //   decoration: InputDecoration(
                  //     hintText: "휴대폰 번호, 이메일 주소 또는 사용자 아이디",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
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
                        if (idFormKey.currentState!.validate()) {
                          ref
                              .read(loginProvider.notifier)
                              .setEmail(idController.text);
                          context.push('/login-enter-pw');
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

//그냥 복붙함 뭔뜻인지 모름
bool isValidEmail(String value) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(value);
}
