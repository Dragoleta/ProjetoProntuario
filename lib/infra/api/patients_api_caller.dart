import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/patient.dart';

Future<List<Patient>?>? getAllPatients(authToken) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/patient/get_all_patients');

    http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "access_token": authToken[0],
            "token_type": authToken[1],
          },
        ));

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return null;
    }
    // Decodes and maps before returning the response
    final List<dynamic> parsed = jsonDecode(res.body);
    List<Patient> yourModels =
        parsed.map((json) => Patient.fromJson(json)).toList();

    return yourModels;
  } catch (e) {
    return null;
  }
}

Future<bool> addPatient(Patient newPatient, authToken) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/patient/add_patient');
    String request = jsonEncode(<String, dynamic>{
      "patient": {
        "workplace_id": newPatient.workplaceID,
        "name": newPatient.name,
        "sex": newPatient.sex,
        "birthdate": newPatient.birthdate,
        "motherName": newPatient.motherName,
        "fatherName": newPatient.fatherName,
        "diagnose": newPatient.diagnose,
      },
      "authToken": {
        "access_token": authToken[0],
        "token_type": authToken[1],
      }
    });

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: request,
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

Future<bool?> deletePatient(authToken, patientId) async {
  try {
    Uri url = Uri.parse(
        '${dotenv.env['API_URL']}/patient/delete_patient?patient_id=$patientId');

    http.Response res = await http.delete(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "access_token": authToken[0],
            "token_type": authToken[1],
          },
        ));

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return false;
    }

    return true;
  } catch (e) {
    return false;
  }
}
