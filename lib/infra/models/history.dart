class PatientHistory {
  String? id;
  String? patientId;
  String? text;
  String? appointmentDate;

  PatientHistory(
      {this.id,
      required this.text,
      required this.patientId,
      required this.appointmentDate});

  factory PatientHistory.fromJson(Map<String, dynamic> json) => PatientHistory(
        id: json['id'],
        patientId: json['patient_id'],
        appointmentDate: json['created_at'],
        text: json['text'],
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'patient_id': patientId,
        'appointment_date': appointmentDate,
        'text': text
      };
}
