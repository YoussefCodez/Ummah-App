import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummah/core/config/select_page_cubit.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/theme/app_theme.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/surah_details/presentation/cubit/saved_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ummah/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SelectPageCubit()),
        BlocProvider(create: (context) => getIt<SettingsCubit>()),
        BlocProvider(create: (context) => SavedCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final isDark = state is SettingsLoaded && state.settings.isDarkMode;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              scrollBehavior: const ScrollBehavior().copyWith(
                overscroll: false,
              ),
              home: const MainScreen(),
            );
          },
        ),
      ),
    );
  }
}
