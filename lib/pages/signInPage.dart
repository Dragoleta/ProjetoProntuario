import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
        child: Center(
          child: Column(
            children: [
              const Text('Google sign in'),
              ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: const Text('Sign in with google'))
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await signIn.signIn();

      if (googleSignInAccount == null) {
        return 0;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      print('banana idToken ${googleSignInAuthentication.accessToken}');
    } catch (e) {
      print('Banana Error $e');
    }
  }
}
