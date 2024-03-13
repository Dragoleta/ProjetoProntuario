class PatientHistory {
  String? id;
  late String? patientId;
  late String text;
  late String appointmentDate;

  PatientHistory(
      {this.id,
      required this.text,
      required this.patientId,
      required this.appointmentDate});

  factory PatientHistory.fromJson(Map<String, dynamic> json) => PatientHistory(
        id: json['id'],
        patientId: json['patient_id'],
        appointmentDate: json['appointment_date'],
        text: json['history_text'],
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'patient_id': patientId,
        'appointment_date': appointmentDate,
        'history_text': text
      };
}
