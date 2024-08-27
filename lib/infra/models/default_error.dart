class DefaultError {
  DefaultError({
    required this.code,
    required this.message,
  });

  int code;
  String message;

  factory DefaultError.fromJson(Map<String, dynamic> json) => DefaultError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
