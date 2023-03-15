import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qcamyphotographers/models/workImageUpload/deletImage.model.dart';
import 'package:qcamyphotographers/models/workImageUpload/uploadWorkImage.model.dart';

class UploadWorkImagesNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late UploadImageModel uploadImageModel;

  Future<UploadImageModel> uploadWorkImage({
    required String token,
    required List<XFile>? imageList,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("${urlENDPOINT}upload_workimage_photographers"));
      request.fields['token'] = token;

      //add multiple image to the request
      for (var i = 0; i < imageList!.length; i++) {
        request.files.add(
          http.MultipartFile("image[]", imageList[i].readAsBytes().asStream(),
              await imageList[i].length(),
              filename: imageList[i].name),
        );
      }
      var requestResponse = await request.send();

      //to get response/body from the server/ api
      requestResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = jsonDecode(value) as Map<String, dynamic>;
        // print(jsonResponse);
        // uploadImageModel = UploadImageModel.fromJson(jsonResponse);

        if (requestResponse.statusCode == 200) {
          uploadImageModel = UploadImageModel.fromJson(jsonResponse);
        }
      });
      return uploadImageModel;
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }

  late DeleteImageModel deleteImageModel;
  Future<DeleteImageModel> deleteImage({required String imageId}) async {
    try {
      final request =
          await client.post(Uri.parse("${urlENDPOINT}workimage_remove"), body: {
        "image_id": imageId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        deleteImageModel = DeleteImageModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return deleteImageModel;
  }
}
