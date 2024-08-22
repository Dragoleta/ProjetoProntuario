import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/text_formField.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/api/user_services.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final LocalStorage localStorage;

  const LoginPage({super.key, required this.localStorage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserModel userFromLocalDB;
  String _userEmail = "";
  late String userPassword;

  @override
  void initState() {
    super.initState();
  }

  void _loginUserCall() async {
    var response = await UserServices.loginUser('jorge@example.com', '1234');

    if (response is Failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(WRONG_PASSWORD_OR_EMAIL)),
      );
      return;
    }

    if (response is Success) {
      context.read<UserViewModel>().setAuthToken(response.response);
      Navigator.of(context).pushReplacementNamed('/workplaces');
    }
  }

  Future<void> _setActiveUser() async {
    UserModel? user = await whoAmI(widget.localStorage.getActiveAuthToken());

    widget.localStorage.setCurrentProfessional(user!);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/icons/acme.jpg',
              height: 170,
              width: 170,
            ),
            const SizedBox(height: 70),
            MyTextFormField(
              currentValue: _userEmail,
              onChanged: (value) {
                _userEmail = value;
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
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _loginUserCall();
                  },
                  child: Text(
                    LOGIN,
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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
