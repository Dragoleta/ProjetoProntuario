class Workplace {
  int? id;
  final String name;
  final int professinalID;

  Workplace({this.id, required this.name, required this.professinalID});

  factory Workplace.fromJson(Map<String, dynamic> json) => Workplace(
        id: json['id'],
        name: json['name'],
        professinalID: json['professinal_id'],
      );

  Map<String, dynamic> toJSON() =>
      {'id': id, 'name': name, 'professinal_id': professinalID};
}
