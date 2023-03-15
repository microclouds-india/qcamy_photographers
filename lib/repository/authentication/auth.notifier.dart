import 'package:flutter/material.dart';
import 'package:qcamyphotographers/models/authentication/login.model.dart';
import 'package:qcamyphotographers/repository/authentication/auth.networking.dart';

class LoginNotifier extends ChangeNotifier {
  final LoginNetworking _loginNetworking = LoginNetworking();

  late String mobileNumber;
  bool isLoading = false;

  late LoginModel loginModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  loginUser({required dynamic userName, required String password}) async {
    loading(true);

    try {
      loginModel = await _loginNetworking.loginUser(
          userName: userName, password: password);

      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
