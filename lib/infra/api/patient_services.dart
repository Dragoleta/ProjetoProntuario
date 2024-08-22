import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/utils/constants.dart';

class PatientServices {
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
