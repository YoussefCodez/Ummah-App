import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/features/home/data/models/timing_model.dart';
import 'package:intl/intl.dart';

abstract class HomeLocalDataSource {
  Future<void> saveTimings(TimingModel timingModel, String city);
  TimingModel? getTimings(String city);
}

@LazySingleton(as: HomeLocalDataSource)
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final HiveService _hiveService;

  HomeLocalDataSourceImpl(this._hiveService);

  @override
  Future<void> saveTimings(TimingModel timingModel, String city) async {
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String key = '${today}_$city';
    // Use jsonEncode to convert the nested objects into a simple string for Hive
    final String jsonString = jsonEncode(timingModel.toJson());
    await _hiveService.saveTimings(key, jsonString);
  }

  @override
  TimingModel? getTimings(String city) {
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String key = '${today}_$city';
    final data = _hiveService.getTimings(key);
    if (data == null) return null;

    // The data is stored as a String (via jsonEncode)
    final Map<String, dynamic> json = jsonDecode(data as String);
    return TimingModel.fromJson(json);
  }
}
