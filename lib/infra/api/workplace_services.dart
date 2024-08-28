import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/utils/constants.dart';

class WorkplaceServices {
  static createWorkplace(Workplace placeToCreate, String authToken) async {
    try {
      Uri url = Uri.parse('${dotenv.env['API_URL']}/workplace/add_workplace');

      var workplace = placeToCreate.toJson();

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode(workplace),
      );
      if (201 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
      }

      return Success(code: 200, response: "Success");
    } catch (e) {
      return Failure(
          code: UNKNOWN_ERROR, errorResponse: WORKPLACE_CREATION_ERROR);
    }
  }

  static deleteWorkplace(String authToken, String workplaceId) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['API_URL']}/workplace/delete_workplace?workplace_id=$workplaceId');

      http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken"
        },
      );

      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Response');
      }

      return Success(code: 200, response: "Deleted");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
