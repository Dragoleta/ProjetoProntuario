// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/user.dart';

Future<String> loginApi(User user) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/user/login');

    http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "id": user.id,
          "user_email": user.email,
        }));

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package!');
      return '';
    }
    return res.body.toString();
  } catch (e) {
    print('Banana $e');
    return 'error';
  }
}

Future<bool> createUser(User user) async {
  try {
    print('Banana calling create user');
    Uri url = Uri.parse('${dotenv.env['API_URL']}/user/create_user');

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: user.toJSONApi(),
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package!');
      return false;
    }
    return true;
  } catch (e) {
    print('Banana $e');
    return false;
  }
}
