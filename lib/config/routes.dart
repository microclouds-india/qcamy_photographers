import 'package:flutter/material.dart';
import 'package:qcamyphotographers/views/authentication/login.view.dart';
import 'package:qcamyphotographers/views/home/main.view.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/add_links_views/add_links.view.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/my_bookings_views/booking_details.view.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/my_bookings_views/bookings.view.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/my_bookings_views/diary_search.view.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/my_bookings_views/search_bookings.view.dart';
import 'package:qcamyphotographers/views/home/main/homeTabViews/upload_image_views/upload_images.view.dart';

import '../views/home/main/homeTabViews/my_bookings_views/my_bookings.view.dart';
import '../views/home/main/homeTabViews/past_bookings_views/past_booking_details.view.dart';
import '../views/home/main/homeTabViews/past_bookings_views/past_bookings.view.dart';
import '../views/splashscreen/splash.view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splashView': (context) => const SplashView(),
  '/loginView': (context) => const LoginView(),
  '/mainHomeView': (context) => MainHomeView(),
  '/myBookingsView': (context) => const MyBookingsView(),
  '/bookingsView': (context) => const BookingsView(),
  '/bookingDetailsView': (context) => const BookingDetailsView(),
  '/pastBookingsView': (context) => const PastBookingsView(),
  '/pastBookingDetailsView': (context) => const PastBookingDetailsView(),
  '/uploadImagesView': (context) => const UploadImagesView(),
  '/addLinksView': (context) => const AddLinksView(),
  '/searchBookingsView': (context) => const SearchBookingsView(),
  '/diarySearchView': (context) => const DiarySearchView(),
};
