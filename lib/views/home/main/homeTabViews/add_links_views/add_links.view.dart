// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/repository/upload_images/upload_images.notifier.dart';
import 'package:qcamyphotographers/repository/upload_url/upload_url.notifier.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

import '../../../../../core/token_storage/storage.dart';
import '../../../../../repository/userProfile/userProfile.notifier.dart';

class AddLinksView extends StatelessWidget {
  const AddLinksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlUploadData = Provider.of<UploadUrlNotifier>(context, listen: true);
    final userData =
        Provider.of<PhotographerProfileNotifier>(context, listen: true);
    final workImageData =
        Provider.of<UploadWorkImagesNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Add Links",
          style: GoogleFonts.openSans(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: userData.getPhotographerData(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (userData.photographerProfileModel.links.isEmpty) {
                    return Container(
                      margin: EdgeInsets.only(top: 50,left: 20, right: 20, bottom: 50),
                      child: Center(
                        child: Text(
                          "No Links Added",
                          style: GoogleFonts.openSans(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            userData.photographerProfileModel.links.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Text('Delete Url',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      content: Text(
                                          'Do you want to delete this Url?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('No',style: TextStyle(color: primaryColor),),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await workImageData
                                                .deleteWorkImage(
                                                    imageId: userData
                                                        .photographerProfileModel
                                                        .links[index]
                                                        .id)
                                                .then((value) {
                                              Navigator.of(context).pop(true);
                                            });
                                          },
                                          child: Text('Yes',style: TextStyle(color: primaryColor),),
                                        ),
                                      ],
                                    );
                                  }));
                            },
                            child: SimpleUrlPreview(
                              url: userData
                                  .photographerProfileModel.links[index].link,
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
                        }));
                  }
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              })),
          Center(
            child: Visibility(
              visible: urlUploadData.showAlertBox,
              child: Container(
                width: double.infinity,
                height: 250,
                margin:
                    EdgeInsets.only(left: 50, right: 50, top: 25, bottom: 25),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      urlUploadData.isUpLoading ? "Uploading" : "Done",
                      style: GoogleFonts.openSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    urlUploadData.isUpLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                    MaterialButton(
                      onPressed: () {
                        if (urlUploadData.uploadUrlModel.status == "200") {
                          urlUploadData.alertBoxVisibilty(false);
                          // Navigator.of(context).pop();
                        }
                      },
                      color: Colors.white,
                      elevation: 0,
                      child: Text(
                        urlUploadData.isUpLoading ? "Please wait" : "OK",
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          Consumer<UploadUrlNotifier>(builder: (context, data, _) {
        return FloatingActionButton(
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       final TextEditingController linkTextController =
            //           TextEditingController();

            //       return AlertDialog(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10)),
            //         title: Text("Paste Your Link"),
            //         content: TextField(
            //           keyboardType: TextInputType.multiline,
            //           maxLines: null,
            //           controller: linkTextController,
            //         ),
            //         actions: [
            //           TextButton(
            //             onPressed: () async {
            //               if (linkTextController.text.isNotEmpty) {
            //                 LocalStorage localStorage = LocalStorage();
            //                 final String? token = await localStorage.getToken();
            //                 data.uploadUrl(
            //                     token: token!, url: linkTextController.text);
            //                 // ignore: use_build_context_synchronously
            //                 Navigator.pop(context);
            //                 data.alertBoxVisibilty(true);
            //               }
            //             },
            //             child: Text("Upload"),
            //           )
            //         ],
            //       );
            //     });

            showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController linkTextController =
                      TextEditingController();
                  String url = "";
                  return StatefulBuilder(builder: (context, setState) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                "Paste Your Link",
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SimpleUrlPreview(
                              url: url,
                              previewHeight: 130,
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
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: linkTextController,
                                onChanged: (value) {
                                  setState(() {
                                    url = value;
                                  });
                                },
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                if (linkTextController.text.isNotEmpty) {
                                  LocalStorage localStorage = LocalStorage();
                                  final String? token =
                                      await localStorage.getToken();
                                  data.uploadUrl(
                                      token: token!,
                                      url: linkTextController.text);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  data.alertBoxVisibilty(true);
                                }
                              },
                              color: primaryColor,
                              elevation: 0,
                              child: Text(
                                "Upload",
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
                });
          },
          backgroundColor: primaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        );
      }),
    );
  }
}
