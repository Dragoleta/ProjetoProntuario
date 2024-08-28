import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/api/patient_services.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';
import 'package:prontuario_flutter/infra/models/default_error.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

class PatientViewModel extends ChangeNotifier {
  bool _loading = false;
  List<PatientModel>? _patientList;
  PatientModel? _selectedPatient;
  DefaultError? _patientError;
  Appointment? _selectedAppointment;

  bool get loading => _loading;
  List<PatientModel>? get patientList => _patientList;
  PatientModel? get selectedPatient => _selectedPatient;
  DefaultError? get patientError => _patientError;
  Appointment? get selectedAppointment => _selectedAppointment;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setPatientList(List<PatientModel> patientList) {
    _patientList = patientList;
  }

  setPatient(PatientModel patient) {
    _selectedPatient = patient;
  }

  setPatientError(DefaultError patientError) {
    _patientError = patientError;
  }

  setAppointment(Appointment? selectedAppointment) {
    _selectedAppointment = selectedAppointment;
  }

  getPatients(String authToken, {bool bypass = false}) async {
    if (_patientList != null && bypass == false) {
      return;
    }
    setLoading(true);

    var response = await PatientServices.getPatientsFromAPI(authToken);

    if (response is Success) {
      var jsonResponse = json.decode(response.response as String);
      List<PatientModel> patientList = PatientModel.fromJsonList(jsonResponse);

      setPatientList(patientList);
    }
    if (response is Failure) {
      DefaultError patientError = DefaultError(
        code: response.code,
        message: response.errorResponse,
      );
      setPatientError(patientError);
    }
    setLoading(false);
  }
}
