// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/user.dart';

Future<String> loginApi(String userEmail, String userPassword) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/user/token');

    var payload = {
      'username': userEmail,
      'password': userPassword,
    };

    var res = await http.post(
      url,
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: payload,
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package!');
      return '';
    }

    return res.body;
  } catch (e) {
    print('Banana login $e');
    return 'error';
  }
}

Future<User?>? whoAmI(token) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/user/me');

    var res = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${token[0]}',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package!');
      return null;
    }

    dynamic jsonBody = json.decode(res.body);
    User user = User.fromJson(jsonBody);
    return user;
  } catch (e) {
    print('Banana $e');
  }
  return null;
}

Future<bool> createUser(User user) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/user/create_user');
    user.deleted = false;
    user.createdAt = null;

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: user.toJSONApi(),
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return false;
    }
    return true;
  } catch (e) {
    print('Banana $e');
    return false;
  }
}
