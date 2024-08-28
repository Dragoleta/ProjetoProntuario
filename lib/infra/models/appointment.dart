class Appointment {
  String? id;
  String text;
  String appointmentDate;
  String? createdAt;

  Appointment({
    this.id,
    required this.text,
    required this.appointmentDate,
    this.createdAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        text: json["text"],
        appointmentDate: json["appointment_date"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "_id": id,
        "text": text,
        "appointment_date": appointmentDate,
        if (createdAt != null) "createdAt": createdAt,
      };
}
