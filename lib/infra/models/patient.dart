import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';

class PatientModel {
  String? id;
  String? professionalId;
  String? name;
  String? diagnose;
  String? birthdate;
  String? sex;
  String? motherName;
  String? fatherName;
  String? createdAt;
  List<Appointment>? appointments;
  bool? valid;

  PatientModel({
    this.id,
    this.professionalId,
    this.name,
    this.sex,
    this.diagnose,
    this.birthdate,
    this.motherName,
    this.fatherName,
    this.createdAt,
    this.valid,
    this.appointments,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json['id'],
        professionalId: json['professional_id'],
        name: json['name'],
        sex: json['sex'],
        birthdate: json['birthdate'],
        motherName: json['mother_name'],
        fatherName: json['father_name'],
        diagnose: json['diagnose'],
        createdAt: json['createdAt'],
        appointments: List<Appointment>.from(
            json["appointments"].map((x) => Appointment.fromJson(x))),
      );

  static List<PatientModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PatientModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "professional_id": professionalId,
        "name": name,
        "sex": sex,
        "diagnose": diagnose,
        "birthdate": birthdate,
        "motherName": motherName,
        "fatherName": fatherName,
        "createdAt": createdAt,
        "appointments":
            List<dynamic>.from(appointments!.map((x) => x.toJson())),
      };

  PatientModel copyWith({
    String? name,
    String? diagnose,
    String? birthdate,
    String? sex,
    String? motherName,
    String? fatherName,
  }) {
    return PatientModel(
      name: name ?? this.name,
      diagnose: diagnose ?? this.diagnose,
      birthdate: birthdate ?? this.birthdate,
      sex: sex ?? this.sex,
      motherName: motherName ?? this.motherName,
      fatherName: fatherName ?? this.fatherName,
    );
  }

  String? isEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      valid = false;
      return 'Fill';
    }

    return null;
  }

  List getPatientsList() => [
        NAME,
        SEX,
        BIRTHDATE,
        DIAGNOSE,
        MOTHER_NAME,
        FATHER_NAME,
      ];

  List getValues() => [
        name,
        sex,
        birthdate,
        diagnose,
        motherName,
        fatherName,
      ];
}
