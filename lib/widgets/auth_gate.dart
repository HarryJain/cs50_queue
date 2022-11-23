import 'package:cs50_queue/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // StreamBuilder that listens for changes in the authentication state, i.e.
    //  logging in or out and returns either the sign-in page or homepage
    //  accordingly
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If there is no User from the stream, they are logged out, so return
        //  the SignInScreen
        if (!snapshot.hasData) {
          return const SignInScreen(
            // Configure for email login (here you could also include Google
            //  sign-in, Facebook, Apple, etc.
            providerConfigs: [
              EmailProviderConfiguration(),
            ],
          );
        // If there is a User returned, just show their home screen
        } else {
          return const Home();
        }
      },
    );
  }
}
