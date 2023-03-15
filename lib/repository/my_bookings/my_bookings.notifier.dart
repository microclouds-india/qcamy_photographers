import 'package:flutter/material.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/models/myBookings/conformBooking.model.dart';
import 'package:qcamyphotographers/models/myBookings/searchBookings.model.dart';
import 'package:qcamyphotographers/repository/my_bookings/my_bookings.networking.dart';

import '../../models/myBookings/bookingsDetails.model.dart';
import '../../models/myBookings/myBookings.model.dart';

class MyBookingsNotifier extends ChangeNotifier {
  final MyBookingsNetworking _myBookingsNetworking = MyBookingsNetworking();

  late String bookingId;

  late BookingsModel bookingsModel;
  Future getMyBookings() async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      bookingsModel = await _myBookingsNetworking.getMyBookings(token: token!);

      return bookingsModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  late BookingDetailsModel bookingDetailsModel;
  Future getBookingDetails({required String bookingId}) async {
    try {
      bookingDetailsModel =
          await _myBookingsNetworking.getBookingDetails(bookingId: bookingId);

      return bookingDetailsModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  late ConformBookingModel conformBookingModel;
  bool isLoading = false;
  Future conformBooking(
      {required String bookingId, required String bookingDate}) async {
    isLoading = true;
    notifyListeners();
    try {
      conformBookingModel = await _myBookingsNetworking.conformBooking(
          bookingId: bookingId, bookingDate: bookingDate);
      isLoading = false;
      notifyListeners();

      return conformBookingModel;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.error(e);
    }
  }

  late SearchBookingsModel searchBookingsModel;
  Future searchBookings(
      {required String startDate, required String endDate}) async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      searchBookingsModel = await _myBookingsNetworking.searchBookings(
          token: token!, startDate: startDate, endDate: endDate);

      return searchBookingsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
