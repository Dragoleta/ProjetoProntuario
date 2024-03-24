class PatientHistory {
  String? id;
  String? text;
  String? patientId;
  String? workplaceId;
  String? professionalId;
  bool? deleted;
  String appointmentDate;
  String? createdAt;

  PatientHistory(
      {this.id,
      required this.text,
      required this.patientId,
      required this.appointmentDate,
      required this.workplaceId,
      required this.professionalId,
      this.createdAt,
      this.deleted});

  factory PatientHistory.fromJson(Map<String, dynamic> json) => PatientHistory(
        id: json['id'],
        text: json['text'],
        workplaceId: json['workplace_id'],
        patientId: json['patient_id'],
        professionalId: json['professional_id'],
        appointmentDate: json['appointment_date'],
        createdAt: json['created_at'],
        deleted: json['deleted'],
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'patient_id': patientId,
        'appointment_date': appointmentDate,
        'text': text
      };
}
