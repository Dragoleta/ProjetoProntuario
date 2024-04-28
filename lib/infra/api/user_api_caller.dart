// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/user.dart';

Future<String> loginApi(User user) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/user/login');

    var request = jsonEncode(<String, dynamic>{
      "id": user.id,
      "user_email": user.email,
    });

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: request,
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package!');
      return '';
    }

    return res.body;
  } catch (e) {
    print('Banana $e');
    return 'error';
  }
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
