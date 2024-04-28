import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/helpers/login.dart';
import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class SignInPage extends StatelessWidget {
  final LocalStorage localStorage;
  const SignInPage({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(context,
          actionButtonFuntion: () {}, appbarTitle: CREATEACCOUNT, iconType: 3),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, size.height * 0.3, 0, 0),
        child: Center(
          child: Column(
            children: [
              Text(GOOGLE_CREATE_ACCOUNT),
              ElevatedButton(
                onPressed: () {
                  signIn(localStorage, context);
                },
                child: Text(
                  GOOGLE_CREATE_ACCOUNT,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn(LocalStorage storage, context) async {
    final GoogleSignIn signIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await signIn.signIn();

    if (googleSignInAccount == null) {
      print("banana null");
      return;
    }

    User user = User(
      id: googleSignInAccount.id,
      name: googleSignInAccount.displayName ?? '',
      email: googleSignInAccount.email,
    );
    UserRepo().addUser(user);
    await createUser(user);

    storage.setCurrentProfessional(user);
    await loginHelper(storage, context);
  }

  Future logOrSign(LocalStorage storage, context) async {
    try {
      bool hasData = await checkHasProfessinal(storage);
      if (true != hasData) {
        loginHelper(storage, context);
      } else {
        signIn(storage, context);
      }
    } catch (e) {
      print('Error $e');
    }
  }
}
