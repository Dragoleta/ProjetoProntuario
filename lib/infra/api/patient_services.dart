import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/utils/constants.dart';

class PatientServices {
  static Future<Object> createPatient(
      PatientModel patient, String workplaceID, String authToken) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['API_URL']}/patient/add_patient?workplace_id=$workplaceID');

      print(jsonEncode(patient.toJson()));

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken"
        },
        body: jsonEncode(patient.toJson()),
      );

      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Response');
      }
      return Success(code: 200, response: response.body);
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> getPatientsFromAPI(String authToken) async {
    try {
      Uri url = Uri.parse('${dotenv.env['API_URL']}/patient/get_all_patients');

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

  static deletePatient(String patientId, String authToken) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['API_URL']}/patient/delete_patient?patient_id=$patientId');

      http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken",
        },
      );

      if (201 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
      }

      return Success(code: 200, response: "Success");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
}
