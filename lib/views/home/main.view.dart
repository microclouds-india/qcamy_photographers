// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamyphotographers/config/colors.dart';

import 'main/homeTab.view.dart';
import 'main/profileTab.view.dart';

class MainHomeView extends StatelessWidget {
  MainHomeView({Key? key}) : super(key: key);

  static final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

  final pages = [
    const HomeTabView(),
    const ProfileTabView(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (pageIndexNotifier.value != 0) {
          pageIndexNotifier.value = 0;
        } else {
          showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text('Exit', style: TextStyle(color: Colors.black)),
                  content: Text('Do you want to exit from this app?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No',style: TextStyle(color: primaryColor),),
                    ),
                    TextButton(
                      onPressed: () async {
                        SystemNavigator.pop();
                      },
                      child: Text('Yes',style: TextStyle(color: primaryColor),),
                    ),
                  ],
                );
              }));
        }

        return Future.value(false);
      },
      child: ValueListenableBuilder(
          valueListenable: pageIndexNotifier,
          builder: (context, data, _) {
            return Scaffold(
              body: IndexedStack(
                index: pageIndexNotifier.value,
                children: pages,
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: kBottomNavigationBarHeight - 8,
                        onPressed: () async {
                          pageIndexNotifier.value = 0;
                        },
                        color: pageIndexNotifier.value == 0
                            ? primaryColor
                            : Colors.white,
                        child: Text(
                          "Home",
                          style: GoogleFonts.openSans(
                              color: pageIndexNotifier.value == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        height: kBottomNavigationBarHeight - 8,
                        onPressed: () async {
                          pageIndexNotifier.value = 1;
                        },
                        color: pageIndexNotifier.value == 1
                            ? primaryColor
                            : Colors.white,
                        child: Text(
                          "Profile",
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: pageIndexNotifier.value == 1
                                  ? Colors.white
                                  : Colors.black,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
