import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyphotographers/models/diary/photographer_diary.model.dart';
import 'package:qcamyphotographers/models/diary/search_diary.model.dart';

class DiaryNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late DiaryModel diaryModel;

  Future<DiaryModel> getPhotographerDiary({required dynamic token}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}photographer_dairies"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        diaryModel = DiaryModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return diaryModel;
  }

  late SearchDiaryModel searchDiaryModel;

  Future<SearchDiaryModel> searchDiary(
      {required String token,
      required String startDate,
      required String endDate}) async {
    try {
      final request = await client.post(
          Uri.parse("${urlENDPOINT}photographer_dairies_search"),
          body: {"token": token, "start_date": startDate, "end_date": endDate});

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        searchDiaryModel = SearchDiaryModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return searchDiaryModel;
  }
}
