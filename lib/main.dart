import "package:flutter/material.dart";
import "package:prontuario_flutter/infra/localstorage/local_storage.dart";
import "package:prontuario_flutter/pages/addPatientAppointment.dart";
import "package:prontuario_flutter/pages/addPatientPage.dart";
import "package:prontuario_flutter/pages/appointmentHistory.dart";
import "package:prontuario_flutter/pages/patientPage.dart";
import "package:prontuario_flutter/pages/patientsPage.dart";
import "package:prontuario_flutter/pages/workplacePage.dart";

void main() async {
  LocalStorage storage = LocalStorage();
  runApp(MyApp(storage: storage));
}

class MyApp extends StatelessWidget {
  final LocalStorage storage;

  const MyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkPlacePage(
        localStorage: storage,
      ),
      routes: {
        '/workplaces': (context) => WorkPlacePage(
              localStorage: storage,
            ),
        '/patients': (context) => PatientsPage(
              localStorage: storage,
            ),
        '/patients/add': (context) => AddPatientPage(
              localStorage: storage,
            ),
        '/patients/patient': (context) => PatientPage(
              localStorage: storage,
            ),
        '/patients/patient/appointment': (context) => AppointmentHistoryPage(
              localStorage: storage,
            ),
        '/patients/patient/add': (context) => AddAppointmentPage(
              localStorage: storage,
            ),
      },
    );
  }
}
