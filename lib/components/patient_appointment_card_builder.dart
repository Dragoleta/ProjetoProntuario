import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/appointment_services.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/view_models/patient_view_model.dart';
import 'package:prontuario_flutter/widgets/history_card.dart';

patientAppointmentCardBuilder({
  required PatientViewModel patientViewModel,
  required String authToken,
  required BuildContext context,
}) {
  PatientModel? currentPatient = patientViewModel.selectedPatient;

  selectAppointment(Appointment appointment) {
    print("Banana hit the button");
    patientViewModel.setAppointment(appointment);
    Navigator.of(context).pushNamed("/patients/patient/appointment");
  }

  deleteAppointment(String appointmentID) async {
    await AppointmentServices.deleteAppointment(appointmentID, authToken);
  }

  return ListView.builder(
      shrinkWrap: true,
      itemCount: currentPatient!.appointments!.length,
      itemBuilder: (contexty, index) => historyCard(
            context: contexty,
            appointment: currentPatient.appointments![index],
            cardOnPress: () =>
                selectAppointment(currentPatient.appointments![index]),
            iconOnPress: () =>
                deleteAppointment(currentPatient.appointments![index].id),
          ));
}
