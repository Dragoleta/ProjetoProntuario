import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

// ignore: must_be_immutable
class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback delete;
  final LocalStorage storage;
  const PatientCard(
      {super.key,
      required this.patient,
      required this.delete,
      required this.storage});
  // ignore: empty_constructor_bodies
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
                storage.setCurrentPatient(patient);
                Navigator.of(context).pushNamed('/patients/patient');
              },
              child: Text(
                patient.name ?? 'Text',
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
