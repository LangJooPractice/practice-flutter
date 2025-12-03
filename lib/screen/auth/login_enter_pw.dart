import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginEnterPw extends ConsumerStatefulWidget {
  const LoginEnterPw({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginEnterPwState();
}

class _LoginEnterPwState extends ConsumerState<LoginEnterPw> {
  bool obscure = true;
  final idController = TextEditingController();
  final pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: idController.text,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
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
                          obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      hintText: "비밀번호",
                    ),
                  ),
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
                        context.push('/main');
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
