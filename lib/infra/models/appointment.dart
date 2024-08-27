class Appointment {
  String id;
  String text;
  String appointmentDate;
  String createdAt;

  Appointment({
    required this.id,
    required this.text,
    required this.appointmentDate,
    required this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        text: json["text"],
        appointmentDate: json["appointment_date"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "appointment_date": appointmentDate,
        "createdAt": createdAt,
      };
}
