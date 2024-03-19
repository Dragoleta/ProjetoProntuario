import 'package:prontuario_flutter/infra/api/user_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/repositories/user_repo.dart';

Future<bool> loginHelper(LocalStorage storage) async {
  User? user = storage.getCurrentProfessional();
  if (null == user) {
    print('Banana no current pro');
    return false;
  }
  var response = await loginApi(user);
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
    } else {
      return false;
    }
  } catch (error) {
    print('Banana error $error');
    return false;
  }
}

    // widget.localStorage.setCurrentProfessionalFromDB();
    // sleep(const Duration(seconds: 1));
    // // ignore: unnecessary_null_comparison
    // if (user != null) {
    //   loginHelper(user, widget.localStorage, context);
    //   Navigator.of(context).pushNamed('/workplaces');
    // } else {
    //   print('ldesogado');

    //   // Navigator.of(context).pushNamed('/loginSignin');
    // }