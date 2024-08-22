import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/patient_services.dart';
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
  @override
  void initState() {
    super.initState();
    // patients = getAllPatients(token);
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
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
            child: _ui(userViewModel),
          ),
        ],
      ),
    );
  }

  _ui(UserViewModel userView) {
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
          gestureOnTap: () {},
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

  // FutureBuilder<List<Patient>?> patientsCardsBuilder(LocalStorage storage) {
  //   return FutureBuilder<List<Patient>?>(
  //     future: patients,
  //     builder: (context, AsyncSnapshot<List<Patient>?> snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const CircularProgressIndicator();
  //       } else if (snapshot.hasData) {
  //         if (snapshot.data == null) {
  //           return Text(NO_PATIENTS);
  //         }
  //         return ListView.builder(
  //           itemCount: snapshot.data?.length,
  //           itemBuilder: (context, index) {
  //             if (workplace!.id != snapshot.data![index].workplaceID) {
  //               return const SizedBox(height: 0);
  //             }
  //             Patient patient = snapshot.data![index];
  //             return MyCardWidget(
  //               cardTitle: patient.name ?? "",
  //               gestureOnTap: () async {
  //                 storage.setCurrentPatient(patient);
  //                 Navigator.of(context).pushNamed('/patients/patient');
  //               },
  //               iconOnPress: () async {
  //                 var authToken = storage.getActiveAuthToken();

  //                 if (authToken == null) {
  //                   return;
  //                 }
  //                 bool? response = await deletePatient(authToken, patient.id);
  //                 if (response == true) {
  //                   setState(() {});
  //                 }
  //               },
  //             );
  //           },
  //         );
  //       } else {
  //         return Text(NO_PATIENTS);
  //       }
  //     },
  //   );
  // }
}
