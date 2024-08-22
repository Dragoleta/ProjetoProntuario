class SimplePatient {
  String id;
  String name;

  SimplePatient({
    required this.id,
    required this.name,
  });

  factory SimplePatient.fromJson(Map<String, dynamic> json) => SimplePatient(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
