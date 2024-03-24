import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:prontuario_flutter/infra/localstorage/local_storage.dart";
import "package:prontuario_flutter/pages/addPatientAppointment.dart";
import "package:prontuario_flutter/pages/addPatientPagev2.dart";
import "package:prontuario_flutter/pages/appointmentHistory.dart";
import "package:prontuario_flutter/pages/patientPage.dart";
import "package:prontuario_flutter/pages/patientsPage.dart";
import "package:prontuario_flutter/pages/signInPage.dart";
import "package:prontuario_flutter/pages/startingPage.dart";
import "package:prontuario_flutter/pages/workplacePage.dart";

void main() async {
  await dotenv.load(fileName: ".env");

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
      routes: {
        '/': (context) => StartPage(
              localStorage: storage,
            ),
        '/loginSignin': (context) => SignInPage(
              localStorage: storage,
            ),
        '/workplaces': (context) => WorkplacePage(
              localStorage: storage,
            ),
        '/patients': (context) => PatientsPage(
              localStorage: storage,
            ),
        '/patients/add': (context) => AddPatientPageV2(
              localStorage: storage,
            ),
        '/patients/patient': (context) => PatientPage(
              localStorage: storage,
            ),
        '/patients/patient/appointment': (context) => AppointmentHistoryPage(
              localStorage: storage,
            ),
        '/patients/patient/addAppointment': (context) => AddAppointmentPage(
              localStorage: storage,
            ),
      },
    );
  }
}
