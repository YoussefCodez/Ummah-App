import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/core/services/notification_service.dart';
import 'package:ummah/firebase_options.dart';
import 'package:ummah/my_app.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  configureDependencies();

  await getIt<NotificationService>().init();
  getIt<NotificationService>().requestPermissions();
  getIt<NotificationService>().firebaseMessaging();

  var hive = getIt<HiveService>();
  await hive.init();

  FirebaseMessaging.instance.subscribeToTopic('all');

  runApp(const MyApp());
}
