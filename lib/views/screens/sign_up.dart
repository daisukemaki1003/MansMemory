import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/views/screens/acquaintance_list.dart';

import '../../provider/authentication.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final authentication = ref.watch(authenticationProvider);

    var infoText = ref.watch(infoTextProvider.state);
    infoText.state = '';

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
                    return Text(infoText.state,
                        style: const TextStyle(color: Colors.red));
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
                    // test@sample.co.jp
                    if (signUpResult == FirebaseAuthResultStatus.successful) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const AcquaintanceListScreen();
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

class Emailcheck extends ConsumerWidget {
  const Emailcheck({Key? key, required this.email, required this.password})
      : super(key: key);
  final String email;
  final String password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);
    var isError = false;
    var infoText = ref.watch(infoTextProvider.state);
    final user = ref.watch(currentUserProvider);

    infoText.state = '';

    return Scaffold(
      // メイン画面
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 確認メール送信時のメッセージ
            Container(
              padding: const EdgeInsets.all(8),
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Text(
                    infoText.state,
                    style: TextStyle(
                        color: isError != true ? Colors.black : Colors.red),
                  );
                },
              ),
            ),

            // 確認メールの再送信ボタン
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30.0),
              child: ButtonTheme(
                minWidth: 200.0,
                // height: 100.0,
                child: RaisedButton(
                  // ボタンの形状
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  onPressed: () async {
                    try {
                      // バリデーション後のメールアドレスとパスワードでアカウント登録
                      authentication.signInWithEmailAndPassword(
                          email: email, password: password);

                      // 確認メール送信
                      user!.sendEmailVerification();
                      isError = false;
                      infoText.state = '$email\nに確認メールを送信しました。';
                    } catch (error) {
                      print(error);
                    }
                  },

                  child: const Text(
                    '確認メールを再送信',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  color: Colors.grey,
                ),
              ),
            ),

            // メール確認完了のボタン配置（Home画面に遷移）
            ButtonTheme(
              minWidth: 350.0,
              // height: 100.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  final FirebaseAuthResultStatus signInResult =
                      await authentication.signInWithEmailAndPassword(
                          email: email, password: password);

                  if (user!.emailVerified) {
                    if (signInResult != FirebaseAuthResultStatus.successful) {
                      infoText.state = exceptionMessage(signInResult);
                    } else {
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const AcquaintanceListScreen();
                        }),
                      );
                    }
                  } else {
                    isError = true;
                    infoText.state =
                        'まだメール確認が完了していません。\n確認メール内のリンクをクリックしてください。';
                  }
                },
                child: const Text(
                  'メール確認完了',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
