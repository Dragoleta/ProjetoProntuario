import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/patient_appointment_card_builder.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/infra/view_models/patient_view_model.dart';
import 'package:prontuario_flutter/infra/view_models/user_view_model.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  int _selectedIndex = 0;
  late PatientModel currentPatient;
  late List<Widget> _pages;
  late UserViewModel userViewModel;
  late PatientViewModel patientViewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userViewModel = context.watch<UserViewModel>();
    patientViewModel = context.watch<PatientViewModel>();
    currentPatient = patientViewModel.selectedPatient!;
    _pages = _buildPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {},
        appbarTitle: PATIENT_PROFILE,
        iconType: 3,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              tooltip: NEW_APPOINTMENT,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/patients/patient/addAppointment');
              },
            )
          : null,
      bottomNavigationBar: myBottomNavBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }

  List<Widget> _buildPages() {
    return <Widget>[
      Column(
        children: [
          Expanded(
            child: patientAppointmentCardBuilder(
              context: context,
              patientViewModel: patientViewModel,
              authToken: userViewModel.authToken!,
            ),
          ),
        ],
      ),
      PatientInfo(
        currentPatient: currentPatient,
      ),
      Center(
        child: ElevatedButton(
          onPressed: () {
            _launchApp();
          },
          child: const Text(
            'Open google Drive',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ];
  }

  _launchApp() async {
    var url = Uri.parse("https://drive.google.com/drive/u/0/my-drive");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar myBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.book), label: HISTORY),
        BottomNavigationBarItem(
            icon: const Icon(Icons.supervised_user_circle), label: PROFILE),
        BottomNavigationBarItem(icon: const Icon(Icons.upload), label: UPLOADS),
      ],
    );
  }
}

class PatientInfo extends StatelessWidget {
  final PatientModel? currentPatient;

  const PatientInfo({
    super.key,
    required this.currentPatient,
  });

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    List patientFields = currentPatient!.getPatientsList();
    var test = currentPatient?.getValues();
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(patientFields[index] + ":"),
          subtitle: Text(test?[index] ?? "Not found"),
        );
      },
    );
  }
}
