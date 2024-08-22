import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/utils/constants.dart';

class UserServices {
  static Future<Object> getUser(String authToken) async {
    try {
      Uri url = Uri.parse('${dotenv.env['API_URL']}/user/me');

      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken"
        },
      );

      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Response');
      }

      return Success(code: 200, response: response.body);
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> loginUser(String userEmail, String userPassword) async {
    try {
      Uri url = Uri.parse('${dotenv.env['API_URL']}/user/token');
      var payload = {
        'username': userEmail,
        'password': userPassword,
      };

      var response = await http.post(
        url,
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: payload,
      );
      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Response');
      }

      return Success(code: 200, response: response.body);
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
