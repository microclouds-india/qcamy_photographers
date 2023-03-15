class LoginModel {
  LoginModel({
    required this.message,
    required this.status,
    required this.logged,
    required this.response,
    required this.token,
  });

  String message;
  String status;
  String logged;
  String response;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"] ?? "",
        status: json["status"],
        logged: json["logged"] ?? "",
        response: json["response"] ?? "",
        token: json["token"] ?? "",
      );
}
