import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';
import 'package:prontuario_flutter/infra/repositories/history_repo.dart';
import 'package:prontuario_flutter/infra/repositories/patients_repo.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:prontuario_flutter/widgets/patients_card.dart';

class PatientsPage extends StatefulWidget {
  final LocalStorage localStorage;

  const PatientsPage({super.key, required this.localStorage});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) {
    Workplace? workplace = widget.localStorage.getCurrentPlace();
    return Scaffold(
        appBar: customAppBar(
          context,
          actionButtonFuntion: () async {
            Navigator.of(context).pushNamed('/patients/add');
            setState(() {});
          },
          appbarTitle: workplace.name,
          iconType: 0,
        ),
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Expanded(child: patientsCardsBuilder(widget.localStorage))
          ],
        ));
  }

  FutureBuilder<List<Patient>?> patientsCardsBuilder(LocalStorage storage) {
    Workplace? workplace = storage.getCurrentPlace();
    return FutureBuilder<List<Patient>?>(
      future: PatientsRepo().getAllPatientsFromWorkplace(workplace.id),
      builder: (context, AsyncSnapshot<List<Patient>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Text('No Patients');
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return PatientCard(
                storage: storage,
                patient: snapshot.data![index],
                delete: () async {
                  HistoryRepo()
                      .deleteAllUsersAppointments(snapshot.data![index]);
                  PatientsRepo().deletePatientFromDb(snapshot.data![index]);
                  setState(() {});
                },
              );
            },
          );
        } else {
          return Text('Nothing here $snapshot');
        }
      },
    );
  }
}
