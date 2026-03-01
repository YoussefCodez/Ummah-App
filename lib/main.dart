import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  configureDependencies();
  var hive = getIt<HiveService>();
  await hive.init();
  runApp(const MyApp());
}
