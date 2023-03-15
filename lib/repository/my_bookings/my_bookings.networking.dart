import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyphotographers/models/myBookings/conformBooking.model.dart';
import 'package:qcamyphotographers/models/myBookings/myBookings.model.dart';
import 'package:qcamyphotographers/models/myBookings/searchBookings.model.dart';

import '../../models/myBookings/bookingsDetails.model.dart';

class MyBookingsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late BookingsModel bookingsModel;

  Future<BookingsModel> getMyBookings({required dynamic token}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}photographer_bookings"), body: {
        "token": token,
      });

      print(token);
      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        bookingsModel = BookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return bookingsModel;
  }

  late BookingDetailsModel bookingDetailsModel;
  Future<BookingDetailsModel> getBookingDetails(
      {required String bookingId}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}photographer_booking_details"), body: {
        "booking_id": bookingId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        bookingDetailsModel = BookingDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return bookingDetailsModel;
  }

  late ConformBookingModel conformBookingModel;
  Future<ConformBookingModel> conformBooking(
      {required String bookingId, required String bookingDate}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}photographer_confirm_booking"), body: {
        "booking_id": bookingId,
        "request": "accepted",
        "booking_date": bookingDate
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        conformBookingModel = ConformBookingModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return conformBookingModel;
  }

  late SearchBookingsModel searchBookingsModel;
  Future<SearchBookingsModel> searchBookings(
      {required String token,
      required String startDate,
      required String endDate}) async {
    try {
      final request = await client.post(
          Uri.parse("${urlENDPOINT}photographer_search_booking"),
          body: {"token": token, "start_date": startDate, "end_date": endDate});

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        searchBookingsModel = SearchBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return searchBookingsModel;
  }
}
