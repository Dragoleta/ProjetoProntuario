import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/repositories/history_repo.dart';
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
    Patient patient = widget.localStorage.getCurrentPatient();
    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {},
        appbarTitle: 'New Appointment',
        iconType: 2,
      ),
      backgroundColor: Colors.grey,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _date,
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_outlined),
                    labelText: "Select date"),
                onTap: () async {
                  DateTime? datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (datePicked != null) {
                    setState(() {
                      _date.text = DateFormat('dd.MM.yyyy').format(datePicked);
                    });
                  }
                  if (datePicked == null) {
                    setState(() {
                      _date.text =
                          DateFormat('dd.MM.yyyy').format(DateTime.now());
                      debugPrint('banana');
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
                      onPressed: () {
                        PatientHistory history = PatientHistory(
                            text: _appointment.text,
                            patientId: patient.id,
                            appointmentDate: _date.text);
                        HistoryRepo().addHistory(history);
                        Navigator.of(context).pop();
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
        decoration: const InputDecoration(
          labelText: 'Write a history',
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          labelStyle: TextStyle(fontSize: 18, color: Colors.black87),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purpleAccent, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}
