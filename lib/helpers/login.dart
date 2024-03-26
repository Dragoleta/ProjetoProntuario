import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';

Future<bool> loginHelper(LocalStorage storage) async {
  User? user = storage.getCurrentProfessional();

  if (null == user) {
    print('Banana no current professinal');
    return false;
  }
  var response = await loginApi(user);
  if ('' == response) {
    print('Banana user not found');
    return false;
  }

  storage.setCurrentProfessional(user);
  storage.setActiveAuthToken(response);
  return true;
}

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
