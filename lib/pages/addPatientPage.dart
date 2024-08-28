import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/add_patient_form.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/api_status.dart';
import 'package:prontuario_flutter/infra/api/patient_services.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/view_models/user_view_model.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:provider/provider.dart';

class AddPatientPageV3 extends StatefulWidget {
  const AddPatientPageV3({super.key});

  @override
  State<AddPatientPageV3> createState() => _AddPatientPageV3State();
}

class _AddPatientPageV3State extends State<AddPatientPageV3> {
  final formKey = GlobalKey<FormState>();
  var model = PatientModel();
  @override
  Widget build(BuildContext context) {
    String workplaceID = context.watch<UserViewModel>().selectedWorkplace!.id!;
    String authToken = context.watch<UserViewModel>().authToken!;

    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {},
        appbarTitle: ADD_PATIENT,
        iconType: 3,
      ),
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
                  if (model.valid == false) {
                    return;
                  }

                  var response = await PatientServices.createPatient(
                      model, workplaceID, authToken);

                  if (response is Success) {
                    UserViewModel().getUser();
                    Navigator.of(context).pop();
                  }

                  if (response is Failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.errorResponse)),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                ),
                child: Text(
                  'Save',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ))
          ],
        ),
      ),
    );
  }
}
