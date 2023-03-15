class UploadImageModel {
  UploadImageModel({
    required this.message,
    required this.filename,
    required this.filesCount,
    required this.status,
    required this.date,
    required this.time,
    required this.response,
  });

  String message;
  String filename;
  int filesCount;
  String status;
  String date;
  String time;
  String response;

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        message: json["message"] ?? "",
        filename: json["filename"] ?? "",
        filesCount: json["files_count"],
        status: json["status"],
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        response: json["response"] ?? "",
      );
}
