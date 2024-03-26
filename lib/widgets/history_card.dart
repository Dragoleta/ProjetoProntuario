import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/history_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

class PatientHistoryCard extends StatelessWidget {
  final Patient patient;
  final PatientHistory history;
  final LocalStorage storage;
  const PatientHistoryCard(
      {super.key,
      required this.patient,
      required this.history,
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
                storage.setCurrentAppointment(history);
                Navigator.of(context)
                    .pushNamed('/patients/patient/appointment');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    history.appointmentDate,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 10,
                    width: 25,
                  ),
                  SizedBox(
                    width: 210,
                    child: Text(
                      '${history.text}',
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[900],
                      ),
                    ),
                  ),
                ],
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
                bool? response =
                    await deletePatientHistory(authToken, history.id);
                if (response == true) {
                  Navigator.of(context).popAndPushNamed('/patients/patient');
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
