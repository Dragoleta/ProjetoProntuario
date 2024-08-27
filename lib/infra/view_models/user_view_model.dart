import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/api/user_services.dart';
import 'package:prontuario_flutter/infra/models/default_error.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  UserModel? _user;
  DefaultError? _userError;
  String? _authToken;
  Workplace? _selectedWorkplace;

  bool get loading => _loading;
  UserModel? get user => _user;
  String? get authToken => _authToken;
  DefaultError? get userError => _userError;
  Workplace? get selectedWorkplace => _selectedWorkplace;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setWorkplace(Workplace workplaceId) {
    _selectedWorkplace = workplaceId;
  }

  setUser(UserModel user) {
    _user = user;
  }

  setUserError(DefaultError userError) {
    _userError = userError;
  }

  setAuthToken(Object authToken) {
    if (authToken is String) {
      Map<String, dynamic> data = jsonDecode(authToken);
      authToken = data['access_token'];
    }
    _authToken = authToken.toString();
    notifyListeners();
    getUser();
  }

  getUser() async {
    if (_authToken == null) return;
    setLoading(true);

    var response = await UserServices.getUser(_authToken!);

    if (response is Success) {
      var jsonResponse = json.decode(response.response as String);
      UserModel user = UserModel.fromJson(jsonResponse);
      setUser(user);
    }
    if (response is Failure) {
      DefaultError userError = DefaultError(
        code: response.code,
        message: response.errorResponse,
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}
