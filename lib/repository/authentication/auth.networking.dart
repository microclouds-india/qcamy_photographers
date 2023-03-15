import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyphotographers/models/authentication/login.model.dart';

class LoginNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/photographer_login";

  final client = http.Client();

  late LoginModel loginModel;

  //send otp and autehnticate user
  Future<LoginModel> loginUser(
      {required String userName, required String password}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "username": userName,
        "password": password,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        loginModel = LoginModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return loginModel;
  }
}
