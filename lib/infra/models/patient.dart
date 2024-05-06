import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';

class Patient {
  String? id;
  String? professional_Id;
  String? workplaceID;
  String? name;
  String? diagnose;
  String? birthdate;
  String? sex;
  String? motherName;
  String? fatherName;
  String? createdAt;
  bool? deleted;
  bool? valid;

  Patient({
    this.workplaceID,
    this.id,
    this.professional_Id,
    this.name,
    this.sex,
    this.diagnose,
    this.birthdate,
    this.motherName,
    this.fatherName,
    this.createdAt,
    this.deleted,
    this.valid,
  });

  Patient copyWith({
    String? name,
    String? diagnose,
    String? birthdate,
    String? sex,
    String? motherName,
    String? fatherName,
  }) {
    return Patient(
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

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'],
        professional_Id: json['professional_id'],
        workplaceID: json['workplace_id'],
        name: json['name'],
        sex: json['sex'],
        birthdate: json['birthdate'],
        motherName: json['mother_name'],
        fatherName: json['father_name'],
        diagnose: json['diagnose'],
        createdAt: json['createdAt'],
        deleted: json['deleted'],
      );

  String toJSON() {
    return jsonEncode(<String, dynamic>{
      "id": id,
      "professional_id": professional_Id,
      "workplace_id": workplaceID,
      "name": name,
      "sex": sex,
      "birthdate": birthdate,
      "mother_name": motherName,
      "father_name": fatherName,
      "diagnose": diagnose,
      if (createdAt != null) "createdAt": createdAt,
      if (deleted != null) "deleted": deleted
    });
  }

  String convertBirthdate(original) {
    DateTime originalDate = DateTime.parse(original);

    String formattedDate = DateFormat('dd/MM/yyyy').format(originalDate);
    return formattedDate;
  }

  List getPatientsList() => [
        NAME,
        SEX,
        BIRTHDATE,
        DIAGNOSE,
        MOTHER_NAME,
        FATHER_NAME,
      ];
}
