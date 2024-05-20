import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/text_formField.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';

class AccountCreationPage extends StatefulWidget {
  final LocalStorage localStorage;

  const AccountCreationPage({super.key, required this.localStorage});

  @override
  State<AccountCreationPage> createState() => _AccountCreationPageState();
}

class _AccountCreationPageState extends State<AccountCreationPage> {
  final formKey = GlobalKey<FormState>();
  var model = User();
  var confirmPasswords;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MyTextFormField(
                currentValue: model.name,
                onChanged: (value) => model.name = value,
                validator: (value) => model.isEmptyValidator(value),
                focusNode: null,
                nextFocusNode: null,
                labelText: "Name",
              ),
              const SizedBox(height: 16.0),
              MyTextFormField(
                currentValue: model.email,
                onChanged: (value) => model.email = value,
                validator: (value) => model.isValidEmail(value),
                focusNode: null,
                nextFocusNode: null,
                labelText: "Email",
              ),
              const SizedBox(height: 16.0),
              MyTextFormField(
                currentValue: model.password,
                onChanged: (value) => model.password = value,
                validator: (value) => model.isEmptyValidator(value),
                focusNode: null,
                nextFocusNode: null,
                obscureText: true,
                labelText: PASSWORD,
              ),
              const SizedBox(height: 16.0),
              MyTextFormField(
                currentValue: null,
                onChanged: (value) => confirmPasswords = value,
                validator: (value) => model.isEmptyValidator(value),
                focusNode: null,
                nextFocusNode: null,
                obscureText: true,
                labelText: PASSWORD_CONF,
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 100),
                  ElevatedButton(
                    onPressed: () async {
                      if (model.valid == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(Generic_error)),
                        );
                        return;
                      }
                      if (model.password != confirmPasswords) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(PASSWORD_MATCH)),
                        );
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(CREATING_USER)),
                      );

                      var res = await createUser(model);
                      if (res == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(Generic_error)),
                        );
                        return;
                      }
                      UserRepo().addUser(model);

                      Navigator.popAndPushNamed(context, '/login');
                    },
                    child: Text(
                      CREATEACCOUNT,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
