// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/common/ui/Ui.dart';
import 'package:qcamyphotographers/config/image_links.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/repository/userProfile/userProfile.notifier.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData =
        Provider.of<PhotographerProfileNotifier>(context, listen: false);
    return FutureBuilder(
        future: userData.getPhotographerData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor,
              title: Text(
                userData.photographerProfileModel.data[0].name,
                style: GoogleFonts.quicksand(
                    fontSize: 17, color: Colors.white, letterSpacing: 1.2, fontWeight: FontWeight.bold),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  bottom: 5,
                  top: 5,
                ),
                child: CircleAvatar(
                  radius: 50, // Image radius
                  backgroundColor: Colors.grey,
                  // backgroundImage: NetworkImage(
                  //     userData.photographerProfileModel.data[0].profileImage),
                  backgroundImage: CachedNetworkImageProvider(
                    userData.photographerProfileModel.data[0].profileImage
                            .isNotEmpty
                        ? userData.photographerProfileModel.data[0].profileImage
                        : noImage,
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Options(
                      icon: "my_bookings_icon.png",
                      title: "My Bookings",
                      onTap: () {
                        Navigator.of(context).pushNamed("/myBookingsView");
                      },
                    ),
                    Options(
                      icon: "past_bookings_icon.png",
                      title: "Past Bookings",
                      onTap: () {
                        Navigator.of(context).pushNamed("/pastBookingsView");
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Options(
                      icon: "upload_image_icon.png",
                      title: "Upload Work Images",
                      onTap: () {
                        Navigator.of(context).pushNamed("/uploadImagesView");
                      },
                    ),
                    Options(
                      icon: "link_icon.png",
                      title: "Add Links",
                      onTap: () {
                        Navigator.of(context).pushNamed("/addLinksView");
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class Options extends StatelessWidget {
  const Options({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        decoration: Ui.getBoxDecoration(color: primaryColor),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/png/$icon",
            height: 50,
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: GoogleFonts.openSans(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    ));
  }
}
