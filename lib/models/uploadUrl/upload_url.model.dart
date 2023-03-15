class UploadUrlModel {
  UploadUrlModel({
    required this.message,
    required this.url,
    required this.status,
    required this.date,
    required this.time,
    required this.response,
  });

  String message;
  String url;
  String status;
  String date;
  String time;
  String response;

  factory UploadUrlModel.fromJson(Map<String, dynamic> json) => UploadUrlModel(
        message: json["message"] ?? "",
        url: json["url"] ?? "",
        status: json["status"],
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        response: json["response"] ?? "",
      );
}
