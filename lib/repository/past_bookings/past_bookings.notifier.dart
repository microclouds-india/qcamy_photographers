import 'package:flutter/material.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/models/pastBookings/pastBookings.model.dart';
import 'package:qcamyphotographers/repository/past_bookings/past_bookings.networking.dart';

class PastBookingsNotifier extends ChangeNotifier {
  final PastBookingsNetworking _pastBookingsNetworking =
      PastBookingsNetworking();

  late PastBookingsModel pastBookingsModel;
  Future getPastBookings() async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      pastBookingsModel =
          await _pastBookingsNetworking.getPastBookings(token: token!);

      return pastBookingsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
