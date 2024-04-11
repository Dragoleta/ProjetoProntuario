import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/history_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/widgets/history_card.dart';

FutureBuilder<List<PatientHistory>?> patientAppointmentCardBuilder(
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
          return Text(NO_APPOINTMENTS);
        }
        return ListView.builder(
          shrinkWrap: true,
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
        return Text(NO_APPOINTMENTS);
      }
    },
  );
}
