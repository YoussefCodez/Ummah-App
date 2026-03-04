import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/quran_with_tafsir.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/theme/app_colors.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/quran/presentation/screens/widgets/empty_state_view.dart';
import 'package:ummah/features/quran/presentation/screens/widgets/quran_header.dart';
import 'package:ummah/features/quran/presentation/screens/widgets/quran_search_bar.dart';
import 'package:ummah/features/quran/presentation/screens/widgets/saved_pages.dart';
import 'package:ummah/features/quran/presentation/screens/widgets/surah_tile.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:ummah/features/settings/presentation/cubit/settings_state.dart';
import 'package:ummah/features/surah_details/presentation/screens/mushaf_screen.dart';
import 'package:ummah/features/surah_details/presentation/screens/ayah_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuranCubit>()..loadSurahs(),
      child: const QuranView(),
    );
  }
}

class QuranView extends StatelessWidget {
  const QuranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          statusBarBrightness: Theme.of(context).brightness,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const QuranHeader(),
            QuranSearchBar(
              onChanged: (query) =>
                  context.read<QuranCubit>().filterSurahs(query),
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return state is SettingsLoaded &&
                        state.settings.mushafMode == "mushaf"
                    ? const SavedPages()
                    : const SizedBox.shrink();
              },
            ),
            Expanded(
              child: BlocBuilder<QuranCubit, QuranState>(
                builder: (context, state) {
                  if (state is QuranLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuranSuccess) {
                    if (state.filteredSurahs.isNotEmpty) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        itemCount: state.filteredSurahs.length,
                        separatorBuilder: (context, index) => Gap(12.h),
                        itemBuilder: (context, index) {
                          final surah = state.filteredSurahs[index];
                          return BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, type) {
                              return type is SettingsLoaded
                                  ? SurahTile(
                                      surah: surah,
                                      onTap: () {
                                        final startPage = context
                                            .read<QuranCubit>()
                                            .getSurahStartPage(surah.number);
                                        _navigateToSurahDetails(
                                          context: context,
                                          showType: type.settings.mushafMode,
                                          initialPage: startPage,
                                          surah: surah,
                                        );
                                      },
                                    )
                                  : SurahTile(surah: surah, onTap: () {});
                            },
                          );
                        },
                      );
                    } else if (state.filteredAyahs.isNotEmpty) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        itemCount: state.filteredAyahs.length,
                        separatorBuilder: (context, index) => Gap(12.h),
                        itemBuilder: (context, index) {
                          final Ayah ayah = state.filteredAyahs[index];
                          final SurahMetadata surah = state.allSurahs
                              .firstWhere(
                                (s) => s.number == ayah.surahNumber,
                                orElse: () => state.allSurahs.first,
                              );
                          return BlocBuilder<SettingsCubit, SettingsState>(
                            builder: (context, type) {
                              return GestureDetector(
                                onTap: () {
                                  _navigateToSurahDetails(
                                    context: context,
                                    showType: type is SettingsLoaded
                                        ? type.settings.mushafMode
                                        : "mushaf",
                                    initialPage: ayah.page,
                                    surah: surah,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15.r),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${ayah.text}...',
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                      Gap(8.h),
                                      Text(
                                        "Surah ${surah.nameEn} • Ayah ${ayah.id}",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  } else if (state is QuranEmpty) {
                    return const EmptyStateView();
                  } else if (state is QuranFailure) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Gap(80.h),
          ],
        ),
      ),
    );
  }
}

void _navigateToSurahDetails({
  required SurahMetadata surah,
  required BuildContext context,
  required String showType,
  required int initialPage,
}) {
  if (showType == 'mushaf') {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MushafScreen(initialPage: initialPage),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  } else if (showType == "ayah") {
    Navigator.of(
      context,
      rootNavigator: true,
    ).push(CupertinoPageRoute(builder: (context) => AyahScreen(surah: surah)));
  }
}
