import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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

      var response = await fetchAlbum();
      print('Banana $response');
    } catch (e) {
      print('Error $e');
    }
  }

  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('http://127.0.0.1:8000/Health'));
  }
}
