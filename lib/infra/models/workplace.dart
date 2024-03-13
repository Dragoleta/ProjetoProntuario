import 'dart:convert';

class Workplace {
  int? id;
  final String name;
  final int professinalID;
  final DateTime? createdAt;
  final bool? deleted;

  Workplace({
    this.id,
    required this.name,
    required this.professinalID,
    this.createdAt,
    this.deleted,
  });

  factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        id: json['id'],
        name: json['name'],
        professinalID: json['professinal_id'],
        createdAt: json['createdAt'],
        deleted: json['deleted'],
      );

  String toJSON() {
    return jsonEncode(<String, dynamic>{
      "id": id,
      "name": name,
      'professinal_id': professinalID,
      if (createdAt != null) "createdAt": createdAt,
      if (deleted != null) "deleted": deleted
    });
  }
}
