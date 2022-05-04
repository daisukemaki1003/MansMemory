import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mans_memory/provider/navigator_provider.dart';
import 'package:mans_memory/views/screens/user_details.dart';
import 'package:mans_memory/views/screens/user_list.dart';
import 'package:mans_memory/views/screens/sign_in.dart';
import 'provider/authentication_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var page = ref.watch(pageProvider);
    final authentication = ref.watch(authenticationProvider);

    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (authentication.isSignIn) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Navigator(
              pages: [
                if (page == 0)
                  const MaterialPage(
                    child: UserListScreen(),
                  ),
                if (page == 1)
                  MaterialPage(
                    child: UserDetailsScreen(),
                  ),
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) return false;
                ref.read(pageProvider.state).state = 0;
                return true;
              },
            );
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
