import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/profile/profile.model.dart';

class PhotographerProfileNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/profile_photographer";

  final client = http.Client();

  late PhotographerProfileModel photographerProfileModel;

  //get single photographer profile data
  Future<PhotographerProfileModel> getPhotographerProfile(
      {required dynamic token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        photographerProfileModel = PhotographerProfileModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return photographerProfileModel;
  }
}
