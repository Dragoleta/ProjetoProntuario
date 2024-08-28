import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/api/appointment_services.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';
import 'package:prontuario_flutter/infra/view_models/patient_view_model.dart';
import 'package:prontuario_flutter/infra/view_models/user_view_model.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int __activeWidget = 0;
  late PatientViewModel patientViewModel;
  late UserViewModel userViewModel;
  late Appointment currentAppointment;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    patientViewModel = context.watch<PatientViewModel>();
    userViewModel = context.watch<UserViewModel>();

    currentAppointment = patientViewModel.selectedAppointment!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {
          switchWidget();
          setState(() {});
        },
        appbarTitle: PATIENT,
        iconType: 1,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: size.width,
            child: textLocal(currentAppointment),
            // child: Text("history page"),
          ),
          saveButton(currentAppointment, userViewModel.authToken!)
        ],
      ),
      // ,
    );
  }

  void switchWidget() {
    if (__activeWidget == 0) {
      __activeWidget = 1;
    } else if (__activeWidget == 1) {
      __activeWidget = 0;
    }
  }

  Widget saveButton(Appointment currentHistory, authToken) {
    if (__activeWidget == 1) {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).colorScheme.primary)),
        onPressed: () async {
          bool response = await AppointmentServices.updateAppointment(
              currentHistory.id, currentHistory.text, authToken);

          if (response is Failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(Generic_error)),
            );
          }
          if (response is Success) {
            switchWidget();
            setState(() {});
          }
        },
        child: Text(
          SAVE,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    }
    return const SizedBox();
  }

  Widget textLocal(currentHistory) {
    if (__activeWidget == 1) {
      return TextField(
        controller: TextEditingController(text: currentHistory.text),
        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        autofocus: true,
        maxLines: 17,
        autocorrect: true,
        onChanged: (value) {
          currentHistory.text = value;
        },
      );
    }
    return Text(
      currentHistory.text ?? '',
      style: const TextStyle(fontSize: 30),
    );
  }
}
