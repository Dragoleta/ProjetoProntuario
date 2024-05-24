import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

class PatientInfoOri extends StatelessWidget {
  final Patient? currentPatient;
  const PatientInfoOri({
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

class PatientInfo extends StatelessWidget {
  final Patient? currentPatient;

  const PatientInfo({
    super.key,
    required this.currentPatient,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    List patientFields = currentPatient!.getPatientsList();
    var test = currentPatient?.getValues();
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(patientFields[index] + ":"),
          subtitle: Text(test?[index] ?? "Not found"),
        );
      },
    );
  }
}
