import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/views/screens/acquaintance_list.dart';
import 'package:mans_memory/views/screens/sign_in.dart';
import 'provider/authentication.dart';
import 'provider/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  final MaterialColor materialWhite = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);
    final user = ref.watch(userProvider);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: materialWhite,
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (authentication.isSignIn) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            user.create();
            return const AcquaintanceListScreen();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
