import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HiveService {
  late Box locationBox;
  late Box timingsBox;
  late Box azkarBox;
  late Box settingsBox;
  late Box savedPagesBox;
  Future<void> init() async {
    locationBox = await Hive.openBox('location');
    timingsBox = await Hive.openBox('timings');
    azkarBox = await Hive.openBox('azkar');
    settingsBox = await Hive.openBox('settings');
    savedPagesBox = await Hive.openBox('saved_pages');
  }

  Future<void> saveLocation(String location) async {
    await locationBox.put('location', location);
  }

  Future<void> saveDate(DateTime date) async {
    await locationBox.put('date', date);
  }

  String getLocation() {
    return locationBox.get('location') ?? '';
  }

  DateTime getDate() {
    return locationBox.get('date') ?? DateTime.now();
  }

  Future<void> clearLocation() async {
    await locationBox.delete('location');
  }

  Future<void> clearDate() async {
    await locationBox.delete('date');
  }

  // --- Prayer Timings Caching ---

  Future<void> saveTimings(String key, dynamic data) async {
    await timingsBox.put(key, data);
  }

  dynamic getTimings(String key) {
    return timingsBox.get(key);
  }

  Future<void> clearTimings() async {
    await timingsBox.clear();
  }

  // --- Azkar Progress Caching ---

  Future<void> saveAzkarProgress(int categoryId, List<int> counts) async {
    await azkarBox.put('azkar_progress_$categoryId', counts);
  }

  List<int>? getAzkarProgress(int categoryId) {
    final result = azkarBox.get('azkar_progress_$categoryId');
    if (result != null) {
      return List<int>.from(result);
    }
    return null;
  }

  // --- Settings Caching ---

  Future<void> saveSetting<T>(String key, T value) async {
    await settingsBox.put(key, value);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  // --- Saved Pages Caching ---

  Future<void> saveSavedPages(Map<int, dynamic> savedPages) async {
    await savedPagesBox.put('saved_pages', savedPages);
  }

  Map<dynamic, dynamic>? getSavedPages() {
    return savedPagesBox.get('saved_pages') as Map<dynamic, dynamic>?;
  }
}
