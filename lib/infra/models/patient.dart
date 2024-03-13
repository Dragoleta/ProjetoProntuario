class Patient {
  String? id;
  String? professinalID;
  String? workplaceID;
  String? name;
  String? diagnose;
  String? birthdate;
  String? sex;
  String? motherName;
  String? fatherName;

  Patient({
    this.workplaceID,
    this.id,
    this.professinalID,
    this.name,
    this.sex,
    this.diagnose,
    this.birthdate,
    this.motherName,
    this.fatherName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'],
        professinalID: json['professional_id'],
        workplaceID: json['professional_id'],
        name: json['name'],
        sex: json['sex'],
        birthdate: json['birthdate'],
        motherName: json['mother_name'],
        fatherName: json['father_name'],
        diagnose: json['diagnose'],
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'professional_id': professinalID,
        'workplace_id': workplaceID,
        'name': name,
        'sex': sex,
        'birthdate': birthdate,
        'mother_name': motherName,
        'father_name': fatherName,
        'diagnose': diagnose
      };

  List getPatientsList() =>
      ['Name', 'Sex', 'Age', 'Diagnose', "Mother's Name", "Father's Name"];
}
