import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyphotographers/models/pastBookings/pastBookings.model.dart';

class PastBookingsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/photographer_past_bookings";

  final client = http.Client();

  late PastBookingsModel pastBookingsModel;

  //get single photographer profile data
  Future<PastBookingsModel> getPastBookings({required dynamic token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        pastBookingsModel = PastBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return pastBookingsModel;
  }
}
