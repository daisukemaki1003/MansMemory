// ユーザー情報の受け渡しを行うためのProvider
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

// エラー情報の受け渡しを行うためのProvider
final infoTextProvider = StateProvider((ref) => "");

final currentUserProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

final authenticationProvider =
    ChangeNotifierProvider((ref) => Authentication());

// 認証関係
class Authentication extends ChangeNotifier {
  bool _isSignIn = false;
  bool get isSignIn => _isSignIn;

  set isSignIn(bool isSignIn) {
    _isSignIn = isSignIn;
    notifyListeners();
  }

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<FirebaseAuthResultStatus> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    isSignIn = true;

    FirebaseAuthResultStatus result;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      isSignIn = false;

      if (userCredential.user != null) {
        result = FirebaseAuthResultStatus.successful;
      } else {
        result = FirebaseAuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      result = handleException(e);
    }

    return result;
  }

  Future<FirebaseAuthResultStatus> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    isSignIn = true;

    FirebaseAuthResultStatus result;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isSignIn = false;

      if (userCredential.user != null) {
        result = FirebaseAuthResultStatus.successful;
      } else {
        result = FirebaseAuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      result = handleException(e);
    }
    return result;
  }

  Future<User?> signInWithGoogle() async {
    isSignIn = true;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        isSignIn = false;

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        } else if (e.code == 'invalid-credential') {}
      } catch (e) {}
    }

    return user;
  }

  Future<User?> signInWithApple() async {
    isSignIn = true;
    User? user;

    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    try {
      final appleIdCredential = result.credential!;
      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: String.fromCharCodes(appleIdCredential.identityToken!),
        accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      isSignIn = false;

      user = userCredential.user;
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<void> signOut() async {
    isSignIn = true;
    await FirebaseAuth.instance.signOut();
    isSignIn = false;
  }
}

// 認証結果
enum FirebaseAuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

FirebaseAuthResultStatus handleException(FirebaseAuthException e) {
  FirebaseAuthResultStatus result;
  switch (e.code) {
    case 'invalid-email':
      result = FirebaseAuthResultStatus.invalidEmail;
      break;
    case 'wrong-password':
      result = FirebaseAuthResultStatus.wrongPassword;
      break;
    case 'user-disabled':
      result = FirebaseAuthResultStatus.userDisabled;
      break;
    case 'user-not-found':
      result = FirebaseAuthResultStatus.userNotFound;
      break;
    case 'operation-not-allowed':
      result = FirebaseAuthResultStatus.operationNotAllowed;
      break;
    case 'too-many-requests':
      result = FirebaseAuthResultStatus.tooManyRequests;
      break;
    case 'email-already-exists':
      result = FirebaseAuthResultStatus.emailAlreadyExists;
      break;
    default:
      result = FirebaseAuthResultStatus.undefined;
  }
  return result;
}

String exceptionMessage(FirebaseAuthResultStatus result) {
  String? message = '';
  switch (result) {
    case FirebaseAuthResultStatus.successful:
      message = 'ログインに成功しました。';
      break;
    case FirebaseAuthResultStatus.emailAlreadyExists:
      message = '指定されたメールアドレスは既に使用されています。';
      break;
    case FirebaseAuthResultStatus.wrongPassword:
      message = 'パスワードが違います。';
      break;
    case FirebaseAuthResultStatus.invalidEmail:
      message = 'メールアドレスが不正です。';
      break;
    case FirebaseAuthResultStatus.userNotFound:
      message = '指定されたユーザーは存在しません。';
      break;
    case FirebaseAuthResultStatus.userDisabled:
      message = '指定されたユーザーは無効です。';
      break;
    case FirebaseAuthResultStatus.operationNotAllowed:
      message = '指定されたユーザーはこの操作を許可していません。';
      break;
    case FirebaseAuthResultStatus.tooManyRequests:
      message = '指定されたユーザーはこの操作を許可していません。';
      break;
    case FirebaseAuthResultStatus.undefined:
      message = '不明なエラーが発生しました。';
      break;
  }
  return message;
}
