import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/repositories/history_repo.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: customAppBar(
        context,
        // TODO: get hid of the add button on the appBar
        actionButtonFuntion: () async {
          // Navigator.of(context).pushNamed('/patients/add');
          switchWidget();
          setState(() {});
        },
        appbarTitle: currentPatient?.name ?? 'Patient',
        iconType: 1,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: size.width,
            child: test2(size, currentHistory!, widget.localStorage),
          ),
          saveButton(currentHistory)
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

  Widget saveButton(PatientHistory currentHistory) {
    if (__activeWidget == 1) {
      return ElevatedButton(
        onPressed: () {
          HistoryRepo().updateHistory(currentHistory);
          print('banana ${currentHistory.text}');
          switchWidget();
          setState(() {});
        },
        child: const Text('save'),
      );
    }
    return const SizedBox();
  }

  Widget test2(size, PatientHistory currentHistory, LocalStorage localStorage) {
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
