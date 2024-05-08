import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/history.dart';

Future<List<PatientHistory>?>? getPatientHistory(authToken, workplaceId) async {
  try {
    Uri url = Uri.parse(
        '${dotenv.env['API_URL']}/history/get_patient_history?workplace_id=$workplaceId');

    http.Response res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${authToken[0]}"
      },
    );

    if (res.statusCode != 200) {
      print('banana Failed to retrieve the http package! ${res.body}');
      return null;
    }
    // Decodes and maps before returning the response
    final List<dynamic> parsed = jsonDecode(res.body);
    List<PatientHistory> yourModels =
        parsed.map((json) => PatientHistory.fromJson(json)).toList();

    return yourModels;
  } catch (e) {
    return null;
  }
}

Future<bool> addPatientHistory(PatientHistory note, authToken) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/history/add_patient_history');

    String request = jsonEncode(<String, dynamic>{
      "text": note.text,
      "workplace_id": note.workplaceId,
      "patient_id": note.patientId,
      "appointment_date": note.appointmentDate,
    });

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${authToken[0]}"
      },
      body: request,
    );

    if (res.statusCode != 200) {
      print('banana Failed to retrieve the http package! ${res.body}');
      return false;
    }
    return true;
  } catch (e) {
    print('Banana $e');
    return false;
  }
}

Future<bool> updatePatientHistory(
    String? textToUpdate, String? noteId, List authToken) async {
  try {
    Uri url = Uri.parse(
        '${dotenv.env['API_URL']}/history/update_patient_history?text_to_update=$textToUpdate&note_id=$noteId');

    http.Response res = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${authToken[0]}"
      },
    );

    if (res.statusCode != 200) {
      print('banana Failed to retrieve the http package! ${res.body}');
      return false;
    }
    return true;
  } catch (e) {
    print('Banana $e');
    return false;
  }
}

Future<bool?> deletePatientHistory(authToken, patientHistoryId) async {
  try {
    Uri url = Uri.parse(
        '${dotenv.env['API_URL']}/history/delete_patient_history?patient_history_id=$patientHistoryId');

    http.Response res = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${authToken[0]}"
      },
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return false;
    }

    return true;
  } catch (e) {
    return false;
  }
}
