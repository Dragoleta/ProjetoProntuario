import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/patients_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class AddPatientPageV2 extends StatefulWidget {
  final LocalStorage localStorage;

  const AddPatientPageV2({super.key, required this.localStorage});

  @override
  State<AddPatientPageV2> createState() => _AddPatientPageV2State();
}

class _AddPatientPageV2State extends State<AddPatientPageV2> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var currentprofessional = widget.localStorage.getCurrentProfessional();
    Workplace? workplace = widget.localStorage.getCurrentWorkplace();

    List patientFields = Patient().getPatientsList();

    Patient toBePatient = Patient(
        workplaceID: workplace?.id, professional_Id: currentprofessional?.id);
    widget.localStorage.setPatientCreation(toBePatient);

    return Scaffold(
        appBar: customAppBar(
          context,
          // TODO: get hid of the add button on the appBar
          actionButtonFuntion: () async {
            setState(() {});
          },
          appbarTitle: ADD_PATIENT,
          iconType: 0,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              for (String item in patientFields)
                AddPatientCard(
                    currentField: item, localStorage: widget.localStorage),
              ElevatedButton(
                  child: Text(CONTINUE),
                  onPressed: () async {
                    Patient? newPatient =
                        widget.localStorage.getPatientCreation();

                    bool res = await addPatient(
                        newPatient!, widget.localStorage.getActiveAuthToken());

                    if (true == res) {
                      Navigator.of(context).popAndPushNamed('/Workplaces');
                    }

                    if (false == res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Generic_error)),
                      );
                    }
                  })
            ],
          ),
        ));
  }
}

class AddPatientCard extends StatefulWidget {
  final String currentField;
  final LocalStorage localStorage;
  const AddPatientCard(
      {super.key, required this.currentField, required this.localStorage});

  @override
  State<AddPatientCard> createState() => _AddPatientCardState();
}

class _AddPatientCardState extends State<AddPatientCard> {
  final TextEditingController _dateController = TextEditingController();
  List<String> dropItems = ['Masculino', 'Feminino'];

  @override
  Widget build(BuildContext context) {
    if (widget.currentField == "Birthdate") {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 4),
        child: TextFormField(
          controller: _dateController,
          readOnly: true,
          onTap: () {
            _selectDate(context);
          },
          decoration: InputDecoration(
            labelText: widget.currentField,
            prefixIcon: const Icon(Icons.calendar_month),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
          ),
          validator: (value) {
            return textValidator(_dateController.text);
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 4),
      child: TextFormField(
          decoration: InputDecoration(
            hintText: widget.currentField,
          ),
          onChanged: (value) {
            setToPatient(
                widget.currentField.toLowerCase(), value, widget.localStorage);
          },
          onSaved: (value) {
            setToPatient(
                widget.currentField.toLowerCase(), value!, widget.localStorage);
          },
          validator: (value) {
            return textValidator(value);
          }),
    );
  }

  Future<void> _selectDate(context) async {
    Patient? doingPatient = widget.localStorage.getPatientCreation();

    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (datePicked != null) {
      setState(() {
        _dateController.text = datePicked.toString().split(" ")[0];
        doingPatient?.birthdate = datePicked.toString();
        widget.localStorage.setPatientCreation(doingPatient!);
      });
    }
  }
}

String? textValidator(value) {
  if (value == null || value.isEmpty) {
    return NULL_VALUE_ERROR;
  }
  return null;
}

void setToPatient(String currentField, String text, LocalStorage localStorage) {
  Patient? doingPatient = localStorage.getPatientCreation();

  if (currentField == 'name') {
    doingPatient!.name = text;
  } else if (currentField == 'sex') {
    doingPatient!.sex = text;
  } else if (currentField == 'birthdate') {
    doingPatient!.birthdate = text;
  } else if (currentField == 'diagnose') {
    doingPatient!.diagnose = text;
  } else if (currentField == "mother's name") {
    doingPatient!.motherName = text;
  } else if (currentField == "father's name") {
    doingPatient!.fatherName = text;
  }

  localStorage.setPatientCreation(doingPatient!);
}
