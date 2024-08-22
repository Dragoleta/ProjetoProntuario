import 'dart:convert';

import 'package:prontuario_flutter/infra/models/workplace.dart';

UserModel welcomeFromJson(String str) => UserModel.fromJson(json.decode(str));

String welcomeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? createdAt;
  List<Workplace>? workplaces;
  bool? valid;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.createdAt,
    this.workplaces,
    this.valid,
  });

  String? isEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      valid = false;
      return 'Fill';
    }
    valid = true;
    return null;
  }

  String? isValidEmail(String? value) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    bool isValid = emailRegex.hasMatch(value!);

    if (!isValid) {
      valid = false;
      return 'Invalid email';
    }
    valid = true;
    return null;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        workplaces: List<Workplace>.from(
            json["workplaces"].map((x) => Workplace.fromJson(x))),
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJSONLocalDB() => {
        'email': email,
      };

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "workplaces": List<dynamic>.from(workplaces!.map((x) => x.toJson())),
        "createdAt": createdAt,
      };
}
