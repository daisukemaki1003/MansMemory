import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/views/screens/home.dart';
import 'package:mans_memory/views/screens/sign_up.dart';
import 'package:mans_memory/views/widgets/google_sign_in_button.dart';

import '../../provider/authentication_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    var infoText = ref.watch(infoTextProvider.state);
    final authentication = ref.watch(authenticationProvider);

    return Scaffold(
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
                    return Text(
                      infoText.state,
                      style: const TextStyle(color: Colors.red),
                    );
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    final FirebaseAuthResultStatus signInResult =
                        await authentication.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);

                    if (signInResult != FirebaseAuthResultStatus.successful) {
                      infoText.state = exceptionMessage(signInResult);
                    } else {
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const HomeScreen();
                        }),
                      );
                    }
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 80),
                child: Column(children: const [
                  GoogleSignInButton(),
                ]),
              ),

              const SizedBox(
                height: 50,
              ),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                    child: const Text('会員登録はこちらから'),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const SignUpScreen();
                        }),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
