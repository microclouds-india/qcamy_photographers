import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyphotographers/models/uploadUrl/upload_url.model.dart';

class UploadUrlNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/upload_url_photographers";

  final client = http.Client();

  late UploadUrlModel uploadUrlModel;

  Future<UploadUrlModel> uploadUrl(
      {required String token, required String url}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
        "url": url,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        uploadUrlModel = UploadUrlModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return uploadUrlModel;
  }
}
