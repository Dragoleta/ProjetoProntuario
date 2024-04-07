import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/api/patients_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:prontuario_flutter/widgets/card_widget.dart';

class PatientsPage extends StatefulWidget {
  final LocalStorage localStorage;

  const PatientsPage({super.key, required this.localStorage});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) {
    Workplace? workplace = widget.localStorage.getCurrentWorkplace();
    return Scaffold(
        appBar: customAppBar(
          context,
          actionButtonFuntion: () async {
            Navigator.of(context).pushNamed('/patients/add');
            setState(() {});
          },
          appbarTitle: workplace!.name,
          iconType: 0,
        ),
        body: Expanded(child: patientsCardsBuilder(widget.localStorage)));
  }

  FutureBuilder<List<Patient>?> patientsCardsBuilder(LocalStorage storage) {
    Workplace? workplace = storage.getCurrentWorkplace();
    List<String>? token = storage.getActiveAuthToken();

    return FutureBuilder<List<Patient>?>(
      future: getAllPatients(token),
      builder: (context, AsyncSnapshot<List<Patient>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return Text(NO_PATIENTS);
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              if (workplace!.id != snapshot.data![index].workplaceID) {
                return const SizedBox(height: 0);
              }
              Patient patient = snapshot.data![index];
              return MyCardWidget(
                cardTitle: patient.name ?? "",
                gestureOnTap: () async {
                  storage.setCurrentPatient(patient);
                  Navigator.of(context).pushNamed('/patients/patient');
                },
                iconOnPress: () async {
                  var authToken = storage.getActiveAuthToken();

                  if (authToken == null) {
                    return;
                  }
                  bool? response = await deletePatient(authToken, patient.id);
                  if (response == true) {
                    setState(() {});
                  }
                },
              );
            },
          );
        } else {
          return Text(NO_PATIENTS);
        }
      },
    );
  }
}
