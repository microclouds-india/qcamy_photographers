import 'package:flutter/material.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/models/profile/profile.model.dart';

import 'package:qcamyphotographers/repository/userProfile/userProfile.networking.dart';

class PhotographerProfileNotifier extends ChangeNotifier {
  final PhotographerProfileNetworking _photographerProfileNetworking =
      PhotographerProfileNetworking();

  late PhotographerProfileModel photographerProfileModel;
  Future getPhotographerData() async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      // print(token);

      photographerProfileModel = await _photographerProfileNetworking
          .getPhotographerProfile(token: token!);
      notifyListeners();

      return photographerProfileModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
