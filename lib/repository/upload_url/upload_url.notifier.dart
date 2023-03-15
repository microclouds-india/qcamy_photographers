import 'package:flutter/material.dart';
import 'package:qcamyphotographers/models/uploadUrl/upload_url.model.dart';
import 'package:qcamyphotographers/repository/upload_url/upload_url.networking.dart';

class UploadUrlNotifier extends ChangeNotifier {
  final UploadUrlNetworking _uploadUrlNetworking = UploadUrlNetworking();

  bool isUpLoading = false;
  bool showAlertBox = false;

  late UploadUrlModel uploadUrlModel;

  upLoading(bool value) {
    isUpLoading = value;
    notifyListeners();
  }

  alertBoxVisibilty(bool value) {
    showAlertBox = value;
    notifyListeners();
  }

  uploadUrl({required String token, required String url}) async {
    upLoading(true);

    try {
      uploadUrlModel =
          await _uploadUrlNetworking.uploadUrl(token: token, url: url);

      upLoading(false);
    } catch (e) {
      upLoading(false);
    }
  }
}
