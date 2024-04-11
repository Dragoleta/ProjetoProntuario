import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/patient_appointment_card_builder.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';
import 'package:prontuario_flutter/pages/patientPage.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class PatientProfile extends StatefulWidget {
  final LocalStorage localStorage;
  const PatientProfile({super.key, required this.localStorage});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  int _selectedIndex = 0;
  late Patient currentPatient;
  late List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    currentPatient = widget.localStorage.getCurrentPatient()!;
    _pages = _buildPages();
  }

  List<Widget> _buildPages() {
    return <Widget>[
      Expanded(
        child: patientAppointmentCardBuilder(widget.localStorage),
      ),
      PatientInfo(
        patientFields: Patient().getPatientsList(),
        currentPatient: currentPatient,
      ),
      const Text('Home Page'),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar MyBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Uploads'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        actionButtonFuntion: () {},
        appbarTitle: "Paciente profile",
        iconType: 3,
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
