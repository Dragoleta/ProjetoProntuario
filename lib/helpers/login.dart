import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';

Future<bool> checkHasProfessinal(LocalStorage storage) async {
  try {
    User? userFromLocalDB = await UserRepo().getUserFromLocalDB();
    if (null != userFromLocalDB) {
      storage.setCurrentProfessional(userFromLocalDB);
      return true;
    }
    return false;
  } catch (error) {
    print('Banana Error $error');
    return false;
  }
}

Future<bool> loginHelper(LocalStorage storage, context) async {
  User? user = storage.getCurrentProfessional();

  if (null == user) {
    print('Banana no current professinal');
    return false;
  }
  var response = await loginApi("user", "123");
  if ('' == response) {
    print('Banana user not found');
    return false;
  }
  print('Banana logado com sucesso! ${user.name}');
  storage.setCurrentProfessional(user);
  storage.setActiveAuthToken(response);
  Navigator.popAndPushNamed(context, '/workplaces');

  return true;
}
