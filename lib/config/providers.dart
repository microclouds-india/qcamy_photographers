import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qcamyphotographers/repository/diary/diary.notifier.dart';
import 'package:qcamyphotographers/repository/past_bookings/past_bookings.notifier.dart';
import 'package:qcamyphotographers/repository/upload_images/upload_images.notifier.dart';
import 'package:qcamyphotographers/repository/upload_url/upload_url.notifier.dart';
import 'package:qcamyphotographers/repository/userProfile/userProfile.notifier.dart';

import '../repository/authentication/auth.notifier.dart';
import '../repository/my_bookings/my_bookings.notifier.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginNotifier>(create: (context) => LoginNotifier()),
  ChangeNotifierProvider<UploadWorkImagesNotifier>(
      create: (context) => UploadWorkImagesNotifier()),
  ChangeNotifierProvider<UploadUrlNotifier>(
      create: (context) => UploadUrlNotifier()),
  ChangeNotifierProvider<PhotographerProfileNotifier>(
      create: (context) => PhotographerProfileNotifier()),
  ChangeNotifierProvider<PastBookingsNotifier>(
      create: (context) => PastBookingsNotifier()),
  ChangeNotifierProvider<DiaryNotifier>(create: (context) => DiaryNotifier()),
  ChangeNotifierProvider<MyBookingsNotifier>(
      create: (context) => MyBookingsNotifier()),
];
