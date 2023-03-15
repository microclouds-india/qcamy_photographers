import 'package:flutter/material.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      LocalStorage localStorage = LocalStorage();
      await localStorage.getToken().then((value) {
        if (value != null) {
          Navigator.pushReplacementNamed(context, '/mainHomeView');
        } else {
          Navigator.pushReplacementNamed(context, '/loginView');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset("assets/images/png/logo_white.png"),
      ),
    );
  }
}
