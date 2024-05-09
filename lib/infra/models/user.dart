import 'dart:convert';

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  DateTime? createdAt;
  bool? deleted;
  bool? valid;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.createdAt,
      this.deleted,
      this.valid});

  User copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

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

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        password: json["password"],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJSON() => {
        'name': name,
        'email': email,
        "password": password,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (createdAt != null) 'createdAt': createdAt,
        if (deleted != null) 'deleted': deleted
      };

  Map<String, dynamic> toJSONLocalDB() => {
        'email': email,
      };

  String toJSONApi() {
    return jsonEncode(<String, dynamic>{
      "user_email": email,
      "user_name": name,
      "password": password,
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (createdAt != null) "createdAt": createdAt,
      if (deleted != null) "deleted": deleted
    });
  }
}
