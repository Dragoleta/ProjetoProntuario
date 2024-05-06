import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/date_form_field.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/history_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/user.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class AddAppointmentPage extends StatefulWidget {
  final LocalStorage localStorage;
  const AddAppointmentPage({super.key, required this.localStorage});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _appointment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Patient? patient = widget.localStorage.getCurrentPatient();
    Workplace? workplace = widget.localStorage.getCurrentWorkplace();
    User? professional = widget.localStorage.getCurrentProfessional();
    var authToken = widget.localStorage.getActiveAuthToken();

    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {},
        appbarTitle: NEW_APPOINTMENT,
        iconType: 2,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DateFormField(
                hintText: 'Dia da consulta',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill';
                  }
                  return null;
                },
                currentValue: _date.text,
                labelText: 'Consulta',
                onChanged: (value) {
                  _date.text = value;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              textFildcustom(),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_date.text == "" || _appointment.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Por favor preencha todos os campos",
                                ),
                              ),
                            );
                            return;
                          }

                          PatientHistory historyNote = PatientHistory(
                            text: _appointment.text,
                            patientId: patient?.id,
                            workplaceId: workplace?.id,
                            professionalId: professional?.id,
                            deleted: false,
                            appointmentDate: _date.text.toString(),
                          );
                          bool res =
                              await addPatientHistory(historyNote, authToken);
                          if (res == true) {
                            Navigator.of(context).pop();
                          }
                          if (false == res) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(Generic_error),
                              ),
                            );
                          }
                        } catch (e) {
                          print('Banana $e');
                        }
                      },
                      child: Text('Save history',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFildcustom() {
    return SizedBox(
      child: TextField(
        controller: _appointment,
        onSubmitted: (e) {
          _appointment.text = e;
        },
        maxLines: 13,
        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
        decoration: InputDecoration(
          labelText: APPOINTMENT_DETAILS,
          isDense: true,
        ),
      ),
    );
  }
}
