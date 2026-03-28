import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/features/home/data/models/timing_model.dart';

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
    final DateTime now = DateTime.now();
    final String key = '${now.year}_${now.month}_$city';
    final String jsonString = jsonEncode(timingModel.toJson());
    await _hiveService.saveTimings(key, jsonString);
  }

  @override
  TimingModel? getTimings(String city) {
    final DateTime now = DateTime.now();
    final String key = '${now.year}_${now.month}_$city';
    final data = _hiveService.getTimings(key);
    if (data == null) return null;

    final Map<String, dynamic> json = jsonDecode(data as String);
    return TimingModel.fromJson(json);
  }
}
