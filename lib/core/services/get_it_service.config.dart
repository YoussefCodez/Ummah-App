// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:quran_with_tafsir/quran_with_tafsir.dart' as _i934;
import 'package:quran_with_tafsir/services/quran_service.dart' as _i4;

import '../../features/home/data/data_sources/home_local_data_source.dart'
    as _i34;
import '../../features/home/data/repositories/get_timing_by_city_impl.dart'
    as _i551;
import '../../features/home/domain/repositories/get_timing_by_city.dart'
    as _i85;
import '../../features/home/domain/use_cases/get_timing_by_city_usecase.dart'
    as _i189;
import '../../features/home/presentation/cubit/get_timing_by_city_cubit.dart'
    as _i712;
import '../../features/quran/presentation/cubit/quran_cubit.dart' as _i431;
import '../../features/settings/data/data_sources/settings_local_data_source.dart'
    as _i85;
import '../../features/settings/data/data_sources/settings_local_data_source_impl.dart'
    as _i917;
import '../../features/settings/data/repositories/settings_repository_impl.dart'
    as _i955;
import '../../features/settings/domain/repositories/settings_repository.dart'
    as _i674;
import '../../features/settings/presentation/cubit/settings_cubit.dart'
    as _i792;
import '../../features/surah_details/presentation/cubit/quran_tafsir_cubit.dart'
    as _i205;
import '../network/network_info.dart' as _i932;
import 'api_client_service.dart' as _i281;
import 'hive_service.dart' as _i0;
import 'location_service.dart' as _i126;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i0.HiveService>(() => _i0.HiveService());
    gh.lazySingleton<_i126.LocationService>(() => _i126.LocationService());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i161.InternetConnection>(
      () => registerModule.internetConnection,
    );
    gh.lazySingleton<_i4.QuranService>(() => registerModule.getQuranService());
    gh.lazySingleton<_i85.SettingsLocalDataSource>(
      () => _i917.SettingsLocalDataSourceImpl(gh<_i0.HiveService>()),
    );
    gh.lazySingleton<_i34.HomeLocalDataSource>(
      () => _i34.HomeLocalDataSourceImpl(gh<_i0.HiveService>()),
    );
    gh.lazySingleton<_i281.ApiClientService>(
      () => registerModule.getApiClientService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i674.SettingsRepository>(
      () => _i955.SettingsRepositoryImpl(gh<_i85.SettingsLocalDataSource>()),
    );
    gh.factory<_i431.QuranCubit>(
      () => _i431.QuranCubit(gh<_i934.QuranService>()),
    );
    gh.factory<_i205.QuranTafsirCubit>(
      () => _i205.QuranTafsirCubit(gh<_i934.QuranService>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.factory<_i792.SettingsCubit>(
      () => _i792.SettingsCubit(gh<_i674.SettingsRepository>()),
    );
    gh.lazySingleton<_i85.GetTimingByCity>(
      () => _i551.GetTimingByCityImpl(
        gh<_i281.ApiClientService>(),
        gh<_i34.HomeLocalDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i189.GetTimingByCityUsecase>(
      () => _i189.GetTimingByCityUsecase(gh<_i85.GetTimingByCity>()),
    );
    gh.lazySingleton<_i712.GetTimingByCityCubit>(
      () => _i712.GetTimingByCityCubit(gh<_i189.GetTimingByCityUsecase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
