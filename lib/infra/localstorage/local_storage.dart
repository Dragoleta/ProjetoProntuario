import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';

class LocalStorage {
  late Workplace currentPlace;
  late Patient currentPatient;
  late Patient patientCreation;
  late PatientHistory currentHistory;

  late int currentProfessinal;

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

  int getCurrentProfessional() {
//TODO: change this to be set on login
    return 1;
  }

  void setCurrentProfessional(int professional) {
    currentProfessinal = professional;
  }

  PatientHistory getCurrentAppointment() {
    return currentHistory;
  }

  void setCurrentAppointment(PatientHistory appointment) {
    currentHistory = appointment;
  }
}
