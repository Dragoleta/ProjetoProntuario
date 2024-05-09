import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/text_formField.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class LoginPage extends StatefulWidget {
  final LocalStorage localStorage;

  const LoginPage({super.key, required this.localStorage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late User? userFromLocalDB;

  @override
  void initState() {
    super.initState();
    _getUserFromLocalDB();
  }

  void _getUserFromLocalDB() async {
    User? userFromLocalDB2 = await UserRepo().getUserFromLocalDB();

    setState(() {
      userFromLocalDB = userFromLocalDB2;
    });
  }

  @override
  Widget build(BuildContext context) {
    late String userEmail;
    late String userPassword;

    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: null,
        appbarTitle: "Login",
        iconType: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MyTextFormField(
              currentValue:
                  userFromLocalDB == null ? "" : userFromLocalDB?.email,
              onChanged: (value) {
                userEmail = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return FILL;
                }
                return null;
              },
              focusNode: null,
              nextFocusNode: null,
              labelText: "Email",
            ),
            const SizedBox(height: 16.0),
            MyTextFormField(
              currentValue: null,
              onChanged: (value) {
                userPassword = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return FILL;
                }
                return null;
              },
              focusNode: null,
              nextFocusNode: null,
              labelText: PASSWORD,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var res = await loginApi(userEmail, userPassword);
                    if (res == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(WRONG_PASSWORD_OR_EMAIL)),
                      );
                      return;
                    }
                    widget.localStorage.setActiveAuthToken(res);
                    await setActiveUser(widget.localStorage);
                    Navigator.of(context).pushReplacementNamed('/workplaces');
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sigin');
              },
              child: Text(
                SINGUP_MESSAGE,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> setActiveUser(LocalStorage localStorages) async {
  User? user = await whoAmI(localStorages.getActiveAuthToken());

  if (user == null) {
    return;
  }

  localStorages.setCurrentProfessional(user);
  return;
}
