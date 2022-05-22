import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/views/screens/user_list.dart';

import '../../provider/authentication_provider.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final authentication = ref.watch(authenticationProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        '新規登録',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      )),
      body: Center(
        child: Container(
          // padding: const EdgeInsets.all(24),
          padding: const EdgeInsets.fromLTRB(50, 54, 50, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メールアドレス入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                controller: emailController,
              ),

              // パスワード入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(8),
                // メッセージ表示
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return const Text("", style: TextStyle(color: Colors.red));
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('登録'),
                  onPressed: () async {
                    final FirebaseAuthResultStatus signUpResult =
                        await authentication.signUpWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
// @
                    if (signUpResult == FirebaseAuthResultStatus.successful) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const UserListScreen();
                        }),
                      );
                    } else {
                      print(exceptionMessage(signUpResult));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
