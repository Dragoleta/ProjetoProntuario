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
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddAppointmentPage extends StatefulWidget {
  final LocalStorage localStorage;
  const AddAppointmentPage({super.key, required this.localStorage});

  @override
  State<AddAppointmentPage> createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _appointment = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    Patient? patient = widget.localStorage.getCurrentPatient();
    Workplace? workplace = widget.localStorage.getCurrentWorkplace();
    UserModel? professional = widget.localStorage.getCurrentProfessional();
    var authToken = widget.localStorage.getActiveAuthToken();

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
                              SnackBar(
                                content: Text(
                                  FILL,
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
