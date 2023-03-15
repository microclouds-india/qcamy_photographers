import 'package:flutter/material.dart';
import 'package:qcamyphotographers/core/token_storage/storage.dart';
import 'package:qcamyphotographers/models/diary/photographer_diary.model.dart';
import 'package:qcamyphotographers/models/diary/search_diary.model.dart';
import 'package:qcamyphotographers/repository/diary/diary.networking.dart';

class DiaryNotifier extends ChangeNotifier {
  final DiaryNetworking _diaryNetworking = DiaryNetworking();

  late DiaryModel diaryModel;
  Future getPhotographerDiary() async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      diaryModel = await _diaryNetworking.getPhotographerDiary(token: token!);

      return diaryModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  late SearchDiaryModel searchDiaryModel;
  Future searchDiary(
      {required String startDate, required String endDate}) async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      searchDiaryModel = await _diaryNetworking.searchDiary(
          token: token!, startDate: startDate, endDate: endDate);

      return searchDiaryModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
