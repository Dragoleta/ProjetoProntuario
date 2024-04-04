import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _date,
                decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today_outlined),
                  labelText: APPOINTMENT_DATE,
                ),
                onTap: () async {
                  DateTime? datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (datePicked != null) {
                    setState(() {
                      _date.text = DateFormat('dd-MM-yyyy').format(datePicked);
                    });
                  }
                  if (datePicked == null) {
                    setState(() {
                      _date.text =
                          DateFormat('dd-MM-yyyy').format(DateTime.now());
                    });
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              textFildecustom(),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
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
                              SnackBar(content: Text(Generic_error)),
                            );
                          }
                        } catch (e) {
                          print('Banana $e');
                        }
                      },
                      child: const Text('Save history'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return Column(
      children: [textFildecustom(), textFildecustom(), textFildecustom()],
    );
  }

  Widget textFildecustom() {
    return SizedBox(
      child: TextField(
        controller: _appointment,
        onSubmitted: (e) {
          _appointment.text = e;
        },
        maxLines: 13,
        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          labelText: APPOINTMENT_DETAILS,
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.black87),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purpleAccent, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}
