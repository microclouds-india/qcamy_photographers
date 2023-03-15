// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamyphotographers/config/colors.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/repository/upload_images/upload_images.notifier.dart';
import 'package:qcamyphotographers/widgets/success_dialogBox.widget.dart';
import 'package:qcamyphotographers/widgets/view_image.widget.dart';

import '../../../../../repository/userProfile/userProfile.notifier.dart';

class UploadImagesView extends StatefulWidget {
  const UploadImagesView({Key? key}) : super(key: key);

  @override
  State<UploadImagesView> createState() => _UploadImagesViewState();
}

class _UploadImagesViewState extends State<UploadImagesView> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  @override
  Widget build(BuildContext context) {
    //function to select multiple images from gallery
    void selectImages() async {
      try {
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          imageFileList!.addAll(selectedImages);
        }
        // print("Image List Length:" + imageFileList!.length.toString());
        setState(() {});
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    final userData =
        Provider.of<PhotographerProfileNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Upload Images",
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
      body: ListView(
        children: [
          Visibility(
            visible: imageFileList!.isNotEmpty ? true : false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: imageFileList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5, crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewLocalImage(
                                  image: File(imageFileList![index].path),
                                )));
                      },
                      onLongPress: () {
                        //funtions to delete image from list
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('Remove',
                                    style: TextStyle(color: Colors.black)),
                                content: Text('Do you want remove this image?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        imageFileList!.removeAt(index);
                                      });
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            }));
                      },
                      child: Image.file(
                        File(imageFileList![index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ),
          FutureBuilder(
              future: userData.getPhotographerData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (userData.photographerProfileModel.image.isEmpty) {
                    return SizedBox();
                  }
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userData.photographerProfileModel.image.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5, crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewNetworkImage(
                                      imageLink: userData
                                          .photographerProfileModel
                                          .image[index]
                                          .image,
                                    )));
                          },
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
                                    content: Text(
                                        'Do you want to delete this image?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await Provider.of<
                                                      UploadWorkImagesNotifier>(
                                                  context,
                                                  listen: false)
                                              .deleteWorkImage(
                                                  imageId: userData
                                                      .photographerProfileModel
                                                      .image[index]
                                                      .id)
                                              .then((value) {
                                            Navigator.of(context).pop(true);
                                          });
                                          setState(() {});
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                }));
                          },
                          child: Image.network(
                            userData
                                .photographerProfileModel.image[index].image,
                            fit: BoxFit.cover,
                            errorBuilder: ((context, error, stackTrace) {
                              return Container(
                                color: Colors.white,
                              );
                            }),
                          ),
                        );
                      });
                }
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(50),
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectImages();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight - 5,
        child: Consumer<UploadWorkImagesNotifier>(builder: (context, data, _) {
          return data.isLoading
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
              : MaterialButton(
                  onPressed: () async {
                    if (imageFileList!.isNotEmpty) {
                      LocalStorage localStorage = LocalStorage();
                      final String? token = await localStorage.getToken();

                      await data.uploadWorkImages(
                        token: token!,
                        imageList: imageFileList!,
                      );

                      if (data.uploadImageModel.status == "200") {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return SuccessDialog(
                                message:
                                    "Your work images has been uploaded successfully",
                                onOkPressed: () {
                                  Navigator.pop(context);

                                  setState(() {
                                    imageFileList!.clear();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }));
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content:
                                Text("Upload failed.Please try again later."),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Add images to upload"),
                        ),
                      );
                    }
                  },
                  color: imageFileList!.isNotEmpty ? primaryColor : Colors.grey,
                  child: Text(
                    "Upload",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2),
                  ),
                );
        }),
      ),
    );
  }
}
