import 'dart:convert';

import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';

class LocalStorage {
  Workplace? currentPlace;
  Patient? currentPatient;
  Patient? patientCreation;
  PatientHistory? currentHistory;
  User? currentProfessional;
  List<String>? authToken;

  Workplace? getCurrentPlace() {
    return currentPlace;
  }

  void setCurrentPlace(Workplace workplace) {
    currentPlace = workplace;
  }

  Patient? getCurrentPatient() {
    return currentPatient;
  }

  void setCurrentPatient(Patient patient) {
    currentPatient = patient;
  }

  Patient? getPatientCreation() {
    return patientCreation;
  }

  void setPatientCreation(Patient patient) {
    patientCreation = patient;
  }

  String? getCurrentProfessionalId() {
    return currentProfessional?.id ?? '';
  }

  User? getCurrentProfessional() {
    return currentProfessional;
  }

  void setCurrentProfessional(User professional) {
    currentProfessional = professional;
  }

  PatientHistory? getCurrentAppointment() {
    return currentHistory;
  }

  void setCurrentAppointment(PatientHistory appointment) {
    currentHistory = appointment;
  }

  void setActiveAuthToken(String token) {
    Map<String, dynamic> responseJson = jsonDecode(token);
    String accessToken = responseJson['access_token'];
    String tokenType = responseJson['token_type'];
    authToken = [accessToken, tokenType];
  }

  List<String>? getActiveAuthToken() {
    try {
      return authToken;
    } catch (e) {
      print('banana $e');
      return null;
    }
  }
}
