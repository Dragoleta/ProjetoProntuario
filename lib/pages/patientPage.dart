import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/patient_appointment_card_builder.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: customAppBar(
        context,
        actionButtonFuntion: () async {
          Navigator.of(context).pushNamed('/patients/patient/addAppointment');

          setState(() {});
        },
        appbarTitle: currentPatient?.name ?? PATIENT,
        iconType: 0,
      ),
      body: Column(
        children: [
          PatientInfo(
            patientFields: patientFields,
            currentPatient: currentPatient,
          ),
          Expanded(child: patientAppointmentCardBuilder(widget.localStorage))
        ],
      ),
    );
  }
}

class PatientInfo extends StatelessWidget {
  final Patient? currentPatient;
  const PatientInfo({
    super.key,
    required this.patientFields,
    required this.currentPatient,
  });

  final List patientFields;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(maxHeight: size.height, maxWidth: size.width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(patientFields[0] + ':  ' + currentPatient?.name ?? 'Text'),
                Text(patientFields[1] + ':  ' + currentPatient?.sex ?? 'Text'),
                Text(patientFields[3] + ':  ' + currentPatient?.diagnose ??
                    'Text')
              ],
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(patientFields[2] +
                        ':  ' +
                        Patient().convertBirthdate(currentPatient?.birthdate) ??
                    'Text'),
                Text(patientFields[4] + ':  ' + currentPatient?.motherName ??
                    'Text'),
                Text(patientFields[5] + ':  ' + currentPatient?.fatherName ??
                    'Text')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
