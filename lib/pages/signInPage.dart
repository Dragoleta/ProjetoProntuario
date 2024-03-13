import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';

class SignInPage extends StatelessWidget {
  final LocalStorage localStorage;
  const SignInPage({super.key, required this.localStorage});

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
                    logOrSign(localStorage, context);
                  },
                  child: const Text('Sign in with google'))
            ],
          ),
        ),
      ),
    );
  }

  Future logOrSign(LocalStorage storage, context) async {
    try {
      User? userFromLocalDB = await UserRepo().getUserFromLocalDB();

      if (null != userFromLocalDB) {
        login(userFromLocalDB, localStorage, context);
      } else {
        signIn(storage, context);
      }

      // final GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount.authentication;
    } catch (e) {
      print('Error $e');
    }
  }

  void login(User user, LocalStorage storage, context) async {
    var response = await loginApi(user);
    storage.setCurrentProfessional(user);
    storage.setActiveAuthToken(response);
    Navigator.of(context).pushNamed('/workplaces');
  }

  void signIn(LocalStorage storage, context) async {
    final GoogleSignIn signIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await signIn.signIn();

    User user = User(
      id: googleSignInAccount!.id,
      name: googleSignInAccount.displayName ?? '',
      email: googleSignInAccount.email,
    );

    UserRepo().addUser(user);
    bool res = await createUser(user);
    if (true == res) {
      login(user, storage, context);
    }
  }
}
