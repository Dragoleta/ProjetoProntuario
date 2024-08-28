import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';
import 'package:prontuario_flutter/utils/constants.dart';

class AppointmentServices {
  static createAppointment(
      Appointment appointment, String authToken, String patientID) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['API_URL']}/history/add_patient_appointment?patient_id=$patientID');

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode(appointment.toJson()),
      );

      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
      }

      return Success(code: 200, response: "Success");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static updateAppointment(
      String appointmentId, String textToUpdate, String authToken) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['API_URL']}/history/update_patient_history?text_to_update=$textToUpdate&note_id=$appointmentId');

      http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken",
        },
      );

      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
      }

      return Success(code: 200, response: "Success");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static deleteAppointment(
      String appointmentId, String patientID, String authToken) async {
    try {
      Uri url = Uri.parse(
          '${dotenv.env['API_URL']}/history/delete_patient_appointment?patient_appointment_id=$appointmentId&patient_id=$patientID');

      http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $authToken",
        },
      );

      if (200 != response.statusCode) {
        return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
      }

      return Success(code: 200, response: "Success");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
}
