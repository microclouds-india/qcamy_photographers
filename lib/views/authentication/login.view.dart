// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/repository/authentication/auth.notifier.dart';
import 'package:qcamyphotographers/widgets/booking_button.widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(
                  children: [
                    Image.asset("assets/images/png/authscreen_logo.png"),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(top: 130),
                      child: Text(
                        "For Photographers",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 2,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ValueListenableBuilder(
                          valueListenable: _isPasswordVisible,
                          builder: (context, data, _) {
                            return TextField(
                              controller: _passWordController,
                              obscureText: _isPasswordVisible.value,
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _isPasswordVisible.value =
                                        !_isPasswordVisible.value;
                                  },
                                  child: _isPasswordVisible.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {},
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Consumer<LoginNotifier>(builder: (context, data, _) {
                return Container(
                  padding: const EdgeInsets.only(top: 50),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: data.isLoading
                      ? const Center(
                          heightFactor: 1,
                          widthFactor: 1,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: primaryColor,
                            ),
                          ),
                        )
                      : BookingButton(
                          text: "Login",
                          onTap: () async {
                            if (_userNameController.text.isNotEmpty &&
                                _passWordController.text.isNotEmpty) {
                              try {
                                await data.loginUser(
                                  userName: _userNameController.text,
                                  password: _passWordController.text,
                                );

                                if (data.loginModel.status == "200") {
                                  //save token in local storage
                                  LocalStorage localStorage = LocalStorage();
                                  await localStorage
                                      .setToken(data.loginModel.token);
                                  Navigator.of(context)
                                      .pushNamed("/mainHomeView");
                                } else if (data.loginModel.status == "404") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text(data.loginModel.response),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text("Something went wrong!"),
                                    ),
                                  );
                                }
                              } catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text("Something went wrong!"),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text("Please fill all the fields"),
                                ),
                              );
                            }
                          },
                        ),
                );
              }),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Powerd by microclouds",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 2,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
