import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:prontuario_flutter/config/themes/themes.dart";
import "package:prontuario_flutter/infra/view_models/patient_view_model.dart";
import "package:prontuario_flutter/infra/view_models/user_view_model.dart";
import "package:prontuario_flutter/pages/accountCreationPage.dart";
import "package:prontuario_flutter/pages/addPatientAppointment.dart";
import "package:prontuario_flutter/pages/addPatientPage.dart";
import "package:prontuario_flutter/pages/appointmentPage.dart";
import "package:prontuario_flutter/pages/loginPage.dart";
import "package:prontuario_flutter/pages/patientProfilePage.dart";
import "package:prontuario_flutter/pages/patientsPage.dart";
import "package:prontuario_flutter/pages/workplacePage.dart";
import "package:provider/provider.dart";

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

// TODO: redo the provider lopgic
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => PatientViewModel())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          routes: {
            '/': (context) => const LoginPage(),
            '/sigin': (context) => const AccountCreationPage(),
            '/workplaces': (context) => const WorkplacesPage(),
            '/patients': (context) => const PatientsPage(),
            '/patients/add': (context) => const AddPatientPageV3(),
            '/patients/patient': (context) => const PatientProfile(),
            '/patients/patient/appointment': (context) =>
                const AppointmentPage(),
            '/patients/patient/addAppointment': (context) =>
                const AddAppointmentPage(),
          },
        ));
  }
}
