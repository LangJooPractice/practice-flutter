import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Icon(Icons.anchor)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
          child: ListView(
            children: [
              Container(
                child: Center(
                  child: Text(
                    '지금 세계에서 무슨 일이\n'
                    '일어나고 있는지 알아보세요.',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, size: 30),
                    Text("Google로 계속하기"),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Text('또는'),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/login-enter-id');
                },
                child: Text("기존 계정으로 로그인하기"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.push('/register');
                },
                child: Text("회원가입하기"),
              ),
              TextButton(
                onPressed: () {
                  context.go('/main');
                },
                child: Text("메인으로 이동"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
