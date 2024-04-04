import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/history_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class AppointmentHistoryPage extends StatefulWidget {
  final LocalStorage localStorage;
  const AppointmentHistoryPage({super.key, required this.localStorage});

  @override
  State<AppointmentHistoryPage> createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  int __activeWidget = 0;

  @override
  Widget build(BuildContext context) {
    Patient? currentPatient = widget.localStorage.getCurrentPatient();
    PatientHistory? currentHistory =
        widget.localStorage.getCurrentAppointment();
    var authToken = widget.localStorage.getActiveAuthToken();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {
          switchWidget();
          setState(() {});
        },
        appbarTitle: currentPatient?.name ?? PATIENT,
        iconType: 1,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: size.width,
            child: textLocal(size, currentHistory!, widget.localStorage),
          ),
          saveButton(currentHistory, authToken)
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

  Widget saveButton(PatientHistory currentHistory, authToken) {
    if (__activeWidget == 1) {
      return ElevatedButton(
        onPressed: () async {
          bool res = await updatePatientHistory(
              currentHistory.text, currentHistory.id, authToken);

          if (false == res) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(Generic_error)),
            );
          } else {
            switchWidget();
            setState(() {});
          }
        },
        child: Text(SAVE),
      );
    }
    return const SizedBox();
  }

  Widget textLocal(
      size, PatientHistory currentHistory, LocalStorage localStorage) {
    if (__activeWidget == 1) {
      return TextField(
        controller: TextEditingController(text: currentHistory.text),
        autofocus: true,
        maxLines: 17,
        cursorColor: Colors.black,
        autocorrect: true,
        decoration:
            const InputDecoration(filled: true, fillColor: Colors.white),
        onChanged: (value) {
          currentHistory.text = value;
          localStorage.setCurrentAppointment(currentHistory);
        },
      );
    }
    return Text(currentHistory.text ?? '');
  }
}
