import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/infra/repositories/patients_repo.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class AddPatientPage extends StatefulWidget {
  final LocalStorage localStorage;

  const AddPatientPage({super.key, required this.localStorage});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

// TODO: implement user interface a nd add database
class _AddPatientPageState extends State<AddPatientPage> {
  @override
  Widget build(BuildContext context) {
    var currentProfessional = widget.localStorage.getCurrentProfessional();
    Workplace? workplace = widget.localStorage.getCurrentWorkplace();

    List patientFields = Patient().getPatientsList();

    Patient toBePatient = Patient(
        workplaceID: workplace?.id, professional_Id: currentProfessional?.id);
    widget.localStorage.setPatientCreation(toBePatient);
    return Scaffold(
      appBar: customAppBar(
        context,
        // TODO: get hid of the add button on the appBar
        actionButtonFuntion: () async {
          setState(() {});
        },
        appbarTitle: 'Add patient',
        iconType: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: patientFields.length,
              itemBuilder: (BuildContext context, int index) {
                return AddPatientCard(
                    currentField: patientFields[index].toString().toLowerCase(),
                    localStorage: widget.localStorage);
              },
            ),
          ),
          ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                Patient? patient = widget.localStorage.getPatientCreation();
                if (null != patient?.name) {
                  PatientsRepo().addPatient(patient!);
                }
                Navigator.of(context).pushNamed('/patients');
                setState(() {});
              })
        ],
      ),
    );
  }
}

class AddPatientCard extends StatelessWidget {
  final String currentField;
  final LocalStorage localStorage;
  const AddPatientCard(
      {super.key, required this.currentField, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 4),
      child: TextField(
        onChanged: (e) {
          setToPatient(currentField, e, localStorage);
        },
        onSubmitted: (e) {
          setToPatient(currentField, e, localStorage);
        },
        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          labelText: currentField,
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

  void setToPatient(
      String currentField, String text, LocalStorage localStorage) {
    Patient? doingPatient = localStorage.getPatientCreation();

    if (currentField == 'name') {
      doingPatient?.name = text;
    } else if (currentField == 'sex') {
      doingPatient!.sex = text;
    } else if (currentField == 'age') {
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
}
