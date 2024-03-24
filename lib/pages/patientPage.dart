import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/history_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:prontuario_flutter/widgets/history_card.dart';

class PatientPage extends StatefulWidget {
  final LocalStorage localStorage;
  const PatientPage({super.key, required this.localStorage});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    Patient? currentPatient = widget.localStorage.getCurrentPatient();
    Size size = MediaQuery.of(context).size;
    List patientFields = Patient().getPatientsList();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: customAppBar(
        context,
        actionButtonFuntion: () async {
          Navigator.of(context).pushNamed('/patients/patient/addAppointment');

          setState(() {});
        },
        appbarTitle: currentPatient?.name ?? 'Patient',
        iconType: 0,
      ),
      body: Column(
        children: [
          PatientInfo(
            size: size,
            patientFields: patientFields,
            currentPatient: currentPatient,
          ),
          Expanded(child: patientsHistoryCardBuilder(widget.localStorage))
        ],
      ),
    );
  }

  FutureBuilder<List<PatientHistory>?> patientsHistoryCardBuilder(
      LocalStorage storage) {
    Workplace? workplace = storage.getCurrentWorkplace();
    Patient? currentPatient = storage.getCurrentPatient();
    var token = storage.getActiveAuthToken();

    return FutureBuilder<List<PatientHistory>?>(
      future: getPatientHistory(token, workplace?.id),
      builder: (context, AsyncSnapshot<List<PatientHistory>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Text('No Patients');
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return PatientHistoryCard(
                storage: storage,
                patient: currentPatient!,
                history: snapshot.data![index],
              );
            },
          );
        } else {
          return const Text('Nothing here ');
        }
      },
    );
  }
}

class PatientInfo extends StatelessWidget {
  final Patient? currentPatient;
  const PatientInfo({
    super.key,
    required this.size,
    required this.patientFields,
    required this.currentPatient,
  });

  final Size size;
  final List patientFields;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      width: size.width,
      height: size.height * 0.30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(patientFields[0] + ':  ' + currentPatient?.name ?? 'Text'),
              Text(patientFields[1] + ':  ' + currentPatient?.sex ?? 'Text'),
              Text(
                  patientFields[3] + ':  ' + currentPatient?.diagnose ?? 'Text')
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(patientFields[2] + ':  ' + currentPatient?.birthdate ??
                  'Text'),
              Text(patientFields[4] + ':  ' + currentPatient?.motherName ??
                  'Text'),
              Text(patientFields[5] + ':  ' + currentPatient?.fatherName ??
                  'Text')
            ],
          ),
        ],
      ),
    );
  }
}
