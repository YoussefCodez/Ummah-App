import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/core/services/notification_service.dart';
import 'package:ummah/firebase_options.dart';
import 'package:ummah/my_app.dart';

import 'package:easy_localization/easy_localization.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    await Hive.initFlutter();
    await EasyLocalization.ensureInitialized();
    
    configureDependencies();
    final hive = getIt<HiveService>();
    await hive.init();
    
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      FirebaseMessaging.instance.subscribeToTopic('all');

      await getIt<NotificationService>().init();
      getIt<NotificationService>().requestPermissions();
      getIt<NotificationService>().firebaseMessaging();
    } catch (e) {
      debugPrint('Optional systems failed (Firebase/Notifications): $e');
    }

    String languageCode =
        hive.getSetting<String>('languageCode', defaultValue: 'en') ?? 'en';

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: Locale(languageCode),
        child: const MyApp(),
      ),
    );
  } catch (e) {
    debugPrint('CRITICAL INITIALIZATION ERROR: $e');
    runApp(const MaterialApp(home: Scaffold(body: Center(child: Text("Technical Error. Please restart the app.")))));
  } finally {
    FlutterNativeSplash.remove();
  }
}
