import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';

class LocalStorage {
  late Workplace currentPlace;
  late Patient currentPatient;
  late Patient patientCreation;
  late PatientHistory currentHistory;
  late User currentProfessinal;
  late String authToken;

  Workplace getCurrentPlace() {
    return currentPlace;
  }

  void setCurrentPlace(Workplace workplace) {
    currentPlace = workplace;
  }

  Patient getCurrentPatient() {
    return currentPatient;
  }

  void setCurrentPatient(Patient patient) {
    currentPatient = patient;
  }

  Patient getPatientCreation() {
    return patientCreation;
  }

  void setPatientCreation(Patient patient) {
    patientCreation = patient;
  }

  String getCurrentProfessionalId() {
    return currentProfessinal.id ?? '';
  }

  User getCurrentProfessional() {
    return currentProfessinal;
  }

  void setCurrentProfessional(User professional) {
    currentProfessinal = professional;
    print('banana user set');
  }

  PatientHistory getCurrentAppointment() {
    return currentHistory;
  }

  void setCurrentAppointment(PatientHistory appointment) {
    currentHistory = appointment;
  }

  void setActiveAuthToken(String token) {
    authToken = token;
    print('banana token set');
  }

  String getActiveAuthToken() {
    return authToken;
  }
}
