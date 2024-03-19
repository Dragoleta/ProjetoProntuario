import 'dart:convert';

class User {
  String? id;
  String name;
  String email;
  String? phoneNumber;
  DateTime? createdAt;
  bool? deleted;

  User({
    this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.createdAt,
    this.deleted,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        createdAt: json['createdAt'],
        deleted: json['deleted'],
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'email': email,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (createdAt != null) 'createdAt': createdAt,
        if (deleted != null) 'deleted': deleted
      };

  String toJSONApi() {
    return jsonEncode(<String, dynamic>{
      "id": id,
      "user_email": email,
      "user_name": name,
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (createdAt != null) "createdAt": createdAt,
      if (deleted != null) "deleted": deleted
    });
  }
}
