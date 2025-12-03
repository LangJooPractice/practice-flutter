import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginEnterId extends ConsumerStatefulWidget {
  const LoginEnterId({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginEnterIdState();
}

class _LoginEnterIdState extends ConsumerState<LoginEnterId> {
  final idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: "휴대폰 번호, 이메일 주소 또는 사용자 아이디",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
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
                        context.push('/login-enter-pw');
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
