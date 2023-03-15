import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyphotographers/models/workImageUpload/deletImage.model.dart';

import 'package:qcamyphotographers/models/workImageUpload/uploadWorkImage.model.dart';
import 'package:qcamyphotographers/repository/upload_images/upload_images.networking.dart';

class UploadWorkImagesNotifier extends ChangeNotifier {
  final UploadWorkImagesNetworking _uploadWorlImagesNetworking =
      UploadWorkImagesNetworking();

  bool isLoading = false;

  late UploadImageModel uploadImageModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future uploadWorkImages({
    required String token,
    required List<XFile> imageList,
  }) async {
    loading(true);

    try {
      uploadImageModel = await _uploadWorlImagesNetworking.uploadWorkImage(
        token: token,
        imageList: imageList,
      );

      loading(false);
      return uploadImageModel;
    } on Exception {
      //catch late initialization error
      uploadImageModel = await _uploadWorlImagesNetworking.uploadWorkImage(
        token: token,
        imageList: imageList,
      );

      loading(false);
      return uploadImageModel;
    } catch (e) {
      loading(false);
      return Future.error(e.toString());
    }
  }

  late DeleteImageModel deleteImageModel;
  Future deleteWorkImage({
    required String imageId,
  }) async {
    try {
      deleteImageModel = await _uploadWorlImagesNetworking.deleteImage(
        imageId: imageId,
      );
      notifyListeners();
      return deleteImageModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
