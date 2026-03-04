import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_with_tafsir/models/surah.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:ummah/features/surah_details/presentation/cubit/is_playing_ayah_cubit.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, required this.ayah});

  final Ayah ayah;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsPlayingAyahCubit, bool>(
      builder: (context, state) {
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.play_circle_outline,
            size: 24.r,
            color: state
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            final quranCubit = context.read<QuranCubit>();
            final playingCubit = context.read<IsPlayingAyahCubit>();

            final audioUrl = quranCubit.getAudioUrl(
              widget.ayah.surahNumber,
              widget.ayah.id,
            );

            if (audioUrl.isNotEmpty) {
              playingCubit.toggle();
              quranCubit.startPlaySpecifcAyah(
                url: audioUrl,
                onComplete: () {
                  playingCubit.toggle();
                },
              );
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(AppStrings.noAudio)));
            }
          },
        );
      },
    );
  }
}
