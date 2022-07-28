import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mans_memory/views/screens/acquaintance_list.dart';
import 'package:mans_memory/views/screens/sign_up.dart';
import '../../provider/user.dart';

import '../../provider/authentication.dart';
import 'terms_of_service.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    var infoText = ref.watch(infoTextProvider.state);
    final authentication = ref.watch(authenticationProvider);
    infoText.state = '';

    return Scaffold(
      body: Center(
        child: Container(
          // padding: const EdgeInsets.all(24),
          padding: const EdgeInsets.fromLTRB(50, 54, 50, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // メールアドレス入力
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'メールアドレス',
                  hintStyle: TextStyle(color: Colors.black),
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 20, bottom: 15, right: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),

              const SizedBox(height: 10),

              // パスワード入力
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'パウワード',
                  hintStyle: TextStyle(color: Colors.black),
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 20, bottom: 15, right: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
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
                      // if (await user.checkExistence()) user.create();
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const AcquaintanceListScreen();
                        }),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 30),

              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: const Divider(color: Colors.black)),
                ),
                const Text('または'),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: const Divider(color: Colors.black)),
                ),
              ]),

              const SizedBox(height: 10),

              SignInButton(
                Buttons.GoogleDark,
                onPressed: () => authentication.signInWithGoogle(),
              ),
              const Divider(),
              SignInButton(
                Buttons.Apple,
                onPressed: () => authentication.signInWithApple(),
              ),

              const Divider(),

              // SignInButton(
              //   Buttons.FacebookNew,
              //   onPressed: () {},
              // ),

              // const Divider(),
              // SignInButton(
              //   Buttons.Twitter,
              //   text: "Use Twitter",
              //   onPressed: () {},
              // ),
              // const Divider(),

              const SizedBox(height: 30),

              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: '登録すると', style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: 'プライバシーポリシー',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const TermsOfServiceScreen();
                        }));
                      }),
                const TextSpan(
                    text: 'に同意したものとみなされます。',
                    style: TextStyle(color: Colors.black))
              ])),

              const SizedBox(height: 30),

              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'アカウントを持ってない場合は',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: 'こちらから',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return const SignUpScreen();
                          }),
                        );
                      }),
              ])),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
