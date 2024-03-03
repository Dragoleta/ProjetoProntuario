import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

// ignore: must_be_immutable
class PatientHistoryCard extends StatelessWidget {
  final Patient patient;
  final PatientHistory history;
  final VoidCallback delete;
  final LocalStorage storage;
  const PatientHistoryCard(
      {super.key,
      required this.patient,
      required this.history,
      required this.delete,
      required this.storage});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // storage.setCurrentPatient(patient);
                storage.setCurrentAppointment(history);
                Navigator.of(context)
                    .pushNamed('/patients/patient/appointment');
              },
              // TODO: Change this to use a more non gambiara
              child: Text(
                '${history.text}          ${history.appointmentDate}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[900],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: delete,
              tooltip: "Delete this patient",
            )
          ],
        ),
      ),
    );
  }
}
