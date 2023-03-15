class DeleteImageModel {
  DeleteImageModel({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory DeleteImageModel.fromJson(Map<String, dynamic> json) =>
      DeleteImageModel(
        message: json["message"] ?? "",
        status: json["status"],
      );
}
