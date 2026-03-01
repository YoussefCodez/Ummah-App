import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:quran_with_tafsir/services/quran_service.dart';
import 'package:ummah/core/services/api_client_service.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  @lazySingleton
  ApiClientService getApiClientService(Dio dio) => ApiClientService(dio);

  @lazySingleton
  QuranService getQuranService() => QuranService.instance;
}
