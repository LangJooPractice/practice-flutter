import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginEnterPw extends ConsumerStatefulWidget {
  const LoginEnterPw({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginEnterPwState();
}

class _LoginEnterPwState extends ConsumerState<LoginEnterPw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Icon(Icons.anchor)));
  }
}
