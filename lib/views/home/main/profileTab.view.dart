// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/common/ui/Ui.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/config/image_links.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/repository/upload_url/upload_url.notifier.dart';
import 'package:qcamyphotographers/views/home/main.view.dart';
import 'package:qcamyphotographers/repository/upload_images/upload_images.notifier.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import '../../../repository/userProfile/userProfile.notifier.dart';
import '../../../widgets/view_image.widget.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const double coverImgSize = 200;
    const double profileImgSize = 80;
    const profileImgPos = coverImgSize - profileImgSize;

    TabController tabController = TabController(length: 2, vsync: this);
    final ValueNotifier<int> tabIndexNotifier = ValueNotifier(0);

    //update the colors of icon and text in tab bar
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        switch (tabController.index) {
          case 0:
            tabIndexNotifier.value = 0;

            break;
          case 1:
            tabIndexNotifier.value = 1;
            break;
        }
      }
    });
    final userData =
        Provider.of<PhotographerProfileNotifier>(context, listen: false);

    Provider.of<UploadWorkImagesNotifier>(context, listen: true);
    Provider.of<UploadUrlNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: primaryColor,
        title: Text(
          "Profile",
          style: GoogleFonts.quicksand(
              color: Colors.white,
              letterSpacing: 1.2,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title:
                          Text('Logout', style: TextStyle(color: Colors.black)),
                      content: Text('Do you want to logout from this account?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            //set to default page
                            MainHomeView.pageIndexNotifier.value = 0;
                            //logout operations
                            LocalStorage localStorage = LocalStorage();
                            await localStorage.deleteToken().whenComplete(() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/loginView", (route) => false);
                            });
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    );
                  }));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: userData.getPhotographerData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.hasError ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            } else {
              if (userData.photographerProfileModel.status != "200") {
                return Center(
                  child: Text("Session experied"),
                );
              }

              return Container(
                margin: EdgeInsets.all(10),
                decoration: Ui.getBoxDecorationProfile(color: primaryColor),
                child: ListView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Container(
                        margin: EdgeInsets.only(bottom: profileImgSize * 1.3),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: Image.network(
                                  userData.photographerProfileModel.data[0]
                                          .coverImage.isNotEmpty
                                      ? userData.photographerProfileModel.data[0]
                                          .coverImage
                                      : imgPlaceHolder,
                                  width: double.infinity,
                                  height: coverImgSize,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      imgPlaceHolder,
                                      width: double.infinity,
                                      height: coverImgSize,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )),
                            Positioned(
                              top: profileImgPos,
                              child: CircleAvatar(
                                radius: profileImgSize,
                                backgroundColor: Colors.grey.shade800,
                                backgroundImage: userData.photographerProfileModel
                                        .data[0].profileImage.isNotEmpty
                                    ? NetworkImage(
                                        userData.photographerProfileModel.data[0]
                                            .profileImage,
                                      )
                                    : NetworkImage(noImagePic),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: Ui.getBoxDecoration(color: primaryColor),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Name",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(": ${userData.photographerProfileModel.data[0].name}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Job",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(": ${userData.photographerProfileModel.data[0].category} Photographer",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Email",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(": ${userData.photographerProfileModel.data[0].username}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Phone Number",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(": ${userData.photographerProfileModel.data[0].phone}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("About",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(": ${userData.photographerProfileModel.data[0].description}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ValueListenableBuilder(
                        valueListenable: tabIndexNotifier,
                        builder: (context, index, _) {
                          return TabBar(
                            indicatorColor: primaryColor,
                            controller: tabController,
                            indicatorWeight: 4,
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.photo_outlined,
                                      color: index == 0
                                          ? primaryColor
                                          : Colors.grey.shade800,
                                      size: 28,
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "Photos",
                                      style: TextStyle(
                                          color: index == 0
                                              ? primaryColor
                                              : Colors.grey.shade800,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.link,
                                      color: index == 1
                                          ? primaryColor
                                          : Colors.grey.shade800,
                                      size: 28,
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "Links",
                                      style: TextStyle(
                                          color: index == 1
                                              ? primaryColor
                                              : Colors.grey.shade800,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                        valueListenable: tabIndexNotifier,
                        builder: (context, index, _) {
                          return IndexedStack(
                            index: tabIndexNotifier.value,
                            children: [
                              Column(
                                children: [
                                  userData.photographerProfileModel.image
                                          .isNotEmpty
                                      ? ImageTabViews(
                                          imageList: userData
                                              .photographerProfileModel.image)
                                      : Container(
                                          height: 100,
                                          alignment: Alignment.center,
                                          child: Text("No images"),
                                        ),
                                ],
                              ),
                              Column(
                                children: [
                                  userData.photographerProfileModel.links
                                          .isNotEmpty
                                      ? ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: userData
                                              .photographerProfileModel
                                              .links
                                              .length,
                                          shrinkWrap: true,
                                          itemBuilder: ((context, index) {
                                            return Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: primaryColor),
                                              ),
                                              child: SimpleUrlPreview(
                                                url: userData
                                                    .photographerProfileModel
                                                    .links[index]
                                                    .link,
                                                previewHeight: 150,
                                                titleStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                descriptionStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                                siteNameStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: primaryColor,
                                                ),
                                                bgColor: Colors.white,
                                              ),
                                            );
                                            // Text(photographerData
                                            //     .photographerProfileModel
                                            //     .links[index]
                                            //     .link);
                                          }))
                                      : Container(
                                          height: 100,
                                          alignment: Alignment.center,
                                          child: Text("No Links"),
                                        ),
                                ],
                              ),
                            ],
                          );
                        })
                  ],
                ),
              );
            }
          }),
    );
  }
}

class ImageTabViews extends StatelessWidget {
  final List imageList;

  const ImageTabViews({Key? key, required this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      crossAxisSpacing: 1,
      mainAxisSpacing: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: imageList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text('Delete Image',
                            style: TextStyle(color: Colors.black)),
                        content: Text('Do you want to delete this image?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await Provider.of<UploadWorkImagesNotifier>(
                                      context,
                                      listen: false)
                                  .deleteWorkImage(imageId: imageList[index].id)
                                  .then((value) {
                                Navigator.of(context).pop(true);
                              });
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    }));
              },
              onTap: () {
                //show image in full screen
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return ViewNetworkImage(imageLink: imageList[index].image);
                })));
              },
              child: Image.network(
                imageList[index].image,
                fit: BoxFit.cover,
                errorBuilder: ((context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                  );
                }),
              ),
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
      },
    );
  }
}
