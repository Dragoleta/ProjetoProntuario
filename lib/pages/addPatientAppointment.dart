import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/date_form_field.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/api/appointment_services.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/view_models/patient_view_model.dart';
import 'package:prontuario_flutter/infra/view_models/user_view_model.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddAppointmentPage extends StatefulWidget {
  const AddAppointmentPage({super.key});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _appointment = TextEditingController();
  late PatientViewModel patientViewModel;
  late UserViewModel userViewModel;
  late PatientModel currentPatient;
  final SpeechToText _speechToText = SpeechToText();

  late bool _speechEnabled;
  String _wordsSpoken = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initSpeech();
    patientViewModel = context.watch<PatientViewModel>();
    userViewModel = context.watch<UserViewModel>();
    currentPatient = patientViewModel.selectedPatient!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {},
        appbarTitle: NEW_APPOINTMENT,
        iconType: 2,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: MIC_TAP,
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        backgroundColor: _speechToText.isListening
            ? Colors.red
            : Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.mic,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DateFormField(
                hintText: APPOINTMENT_DATE,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return FILL;
                  }
                  return null;
                },
                currentValue: _date.text,
                labelText: APPOINTMENT,
                onChanged: (value) {
                  _date.text = value;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              textFieldcustom(),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var response = await callCreateAppointment();

                        if (!context.mounted) {
                          return;
                        }

                        if (response is Success) {
                          patientViewModel.getPatients(
                            userViewModel.authToken!,
                            bypass: true,
                          );
                          Navigator.of(context).pop();
                        }

                        if (response is Failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response.errorResponse),
                            ),
                          );
                        }
                      },
                      child: Text(SAVE,
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

  Future<Object> callCreateAppointment() async {
    if (_date.text == "" || _appointment.text == "") {
      return Failure(code: 103, errorResponse: FILL);
    }

    Appointment appointmentToCreate = Appointment(
      text: _appointment.text,
      appointmentDate: _date.text.toString(),
    );

    Object response = await AppointmentServices.createAppointment(
        appointmentToCreate,
        userViewModel.authToken!,
        patientViewModel.selectedPatient!.id!);

    return response;
  }

  Widget textFieldcustom() {
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

  void initSpeech() async {
    bool speechEnabled = await _speechToText.initialize();
    setState(() {
      _speechEnabled = speechEnabled;
    });
  }

  void _startListening() async {
    var locales = await _speechToText.locales();

    int selectedLocaleIndex =
        locales.indexWhere((locale) => locale.localeId == "pt_BR");

    if (selectedLocaleIndex != -1) {
      var selectedLocaleObject = locales[selectedLocaleIndex];

      _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: selectedLocaleObject.localeId,
      );
    }
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();

    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _wordsSpoken = result.recognizedWords;
      _appointment.text = _wordsSpoken;
    });
  }
}
