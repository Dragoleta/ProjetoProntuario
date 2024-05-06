import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:prontuario_flutter/config/themes/themes.dart";
import "package:prontuario_flutter/infra/localstorage/local_storage.dart";
import "package:prontuario_flutter/pages/accountCreationPage.dart";
import "package:prontuario_flutter/pages/addPatientAppointment.dart";
import "package:prontuario_flutter/pages/addPatientPageV3.dart";
import "package:prontuario_flutter/pages/appointmentHistory.dart";
import "package:prontuario_flutter/pages/loginPage.dart";
import "package:prontuario_flutter/pages/patientProfilePage.dart";
import "package:prontuario_flutter/pages/patientsPage.dart";
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
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/': (context) => LoginPage(
              localStorage: storage,
            ),
        '/sigin': (context) => AccountCreationPage(
              localStorage: storage,
            ),
        '/workplaces': (context) => WorkplacePage(
              localStorage: storage,
            ),
        '/patients': (context) => PatientsPage(
              localStorage: storage,
            ),
        '/patients/add': (context) => AddPatientPageV3(
              localStorage: storage,
            ),
        '/patients/patient': (context) => PatientProfile(
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
