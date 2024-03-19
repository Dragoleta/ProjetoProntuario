import 'dart:convert';

class Workplace {
  String? id;
  String name;
  String professional_Id;
  String? createdAt;
  bool? deleted;

  Workplace({
    this.id,
    required this.name,
    required this.professional_Id,
    this.createdAt,
    this.deleted,
  });

  factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        id: json['id'],
        name: json['name'],
        professional_Id: json['professional_id'],
        createdAt: json['created_at'],
        deleted: json['deleted'],
      );

  String toJSON() {
    return jsonEncode(<String, dynamic>{
      "id": id,
      "name": name,
      'professional_id': professional_Id,
      if (createdAt != null) "createdAt": createdAt,
      if (deleted != null) "deleted": deleted
    });
  }
}
