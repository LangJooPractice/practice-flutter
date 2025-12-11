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

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(postRegisterProvider);
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
            TextField(
              controller: registerEmailController,
              decoration: InputDecoration(hintText: "이메일"),
            ),
            TextField(
              controller: registerPasswordController,
              decoration: InputDecoration(hintText: "비밀번호"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
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
