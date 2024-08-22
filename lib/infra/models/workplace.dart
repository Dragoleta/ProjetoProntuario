import 'package:prontuario_flutter/infra/models/simple_patient.dart';

class Workplace {
  String? id;
  String name;
  List<SimplePatient> patients;
  String? createdAt;

  Workplace({
    this.id,
    required this.name,
    required this.patients,
    this.createdAt,
  });

  factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        id: json["id"],
        name: json["name"],
        patients: List<SimplePatient>.from(
            json["patients"].map((x) => SimplePatient.fromJson(x))),
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "patients": List<dynamic>.from(patients.map((x) => x.toJson())),
        "createdAt": createdAt,
      };
}
