import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/patient_services.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/view_models/patient_view_model.dart';
import 'package:prontuario_flutter/infra/view_models/user_view_model.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:prontuario_flutter/widgets/card_widget.dart';
import 'package:provider/provider.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  late UserViewModel userViewModel;
  late PatientViewModel patientViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userViewModel = context.watch<UserViewModel>();
    patientViewModel = context.watch<PatientViewModel>();
    patientViewModel.getPatients(userViewModel.authToken!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () async {
          Navigator.of(context).pushNamed('/patients/add');
          setState(() {});
        },
        appbarTitle: userViewModel.selectedWorkplace!.name,
        iconType: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _ui(userViewModel, patientViewModel),
          ),
        ],
      ),
    );
  }

  _ui(UserViewModel userView, PatientViewModel patientViewModel) {
    if (userView.loading) {
      return const CircularProgressIndicator();
    }

    if (userView.userError != null) {
      return Container();
    }

    return ListView.builder(
      itemCount: userView.selectedWorkplace!.patients.length,
      itemBuilder: (context, index) {
        return MyCardWidget(
          cardTitle: userView.selectedWorkplace!.patients[index].name,
          gestureOnTap: () async {
            PatientModel patient = patientViewModel.patientList!.firstWhere(
              (p) => p.id == userView.selectedWorkplace!.patients[index].id,
              orElse: () => throw Exception('Patient not found'),
            );
            patientViewModel.setPatient(patient);
            Navigator.of(context).pushNamed('/patients/patient');
          },
          iconOnPress: () {
            PatientServices.deletePatient(
              userView.selectedWorkplace!.patients[index].id,
              userView.authToken!,
            );
          },
        );
      },
    );
  }
}
