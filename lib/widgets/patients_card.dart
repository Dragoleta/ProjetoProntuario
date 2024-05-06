import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/patients_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

// ignore: must_be_immutable
class PatientCard extends StatelessWidget {
  final Patient patient;
  final LocalStorage storage;
  const PatientCard({super.key, required this.patient, required this.storage});
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
              child: SizedBox(
                width: 210,
                child: Text(
                  patient.name ?? 'Text',
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[900],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                var authToken = storage.getActiveAuthToken();

                if (authToken == null) {
                  return;
                }
                bool? response = await deletePatient(authToken, patient.id);
                if (response == true) {
                  Navigator.of(context).popAndPushNamed('/patients');
                }
              },
              tooltip: "Delete this patient",
            )
          ],
        ),
      ),
    );
  }
}
