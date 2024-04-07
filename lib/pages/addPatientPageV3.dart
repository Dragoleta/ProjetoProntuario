import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/add_patient_form.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/patients_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class AddPatientPageV3 extends StatefulWidget {
  final LocalStorage localStorage;

  const AddPatientPageV3({super.key, required this.localStorage});

  @override
  State<AddPatientPageV3> createState() => _AddPatientPageV3State();
}

class _AddPatientPageV3State extends State<AddPatientPageV3> {
  final formKey = GlobalKey<FormState>();
  var model = Patient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          actionButtonFuntion: () {},
          appbarTitle: 'Testing patient new form',
          iconType: 3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddPatientForm(
              formkey: formKey,
              patientModel: model,
              onChanged: (value) => setState(() {
                model = value;
              }),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (model.valid != false) {
                    Workplace? workplace =
                        widget.localStorage.getCurrentWorkplace();
                    model.workplaceID = workplace!.id;
                    widget.localStorage.patientCreation = model;
                    var res = await addPatient(
                        model, widget.localStorage.getActiveAuthToken());

                    if (true == res) {
                      Navigator.of(context).popAndPushNamed('/Workplaces');
                    }

                    if (false == res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Generic_error)),
                      );
                    }
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary)),
                child: Text(
                  'Save',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ))
          ],
        ),
      ),
    );
  }
}
