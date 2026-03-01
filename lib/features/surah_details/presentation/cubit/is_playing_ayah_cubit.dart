import 'package:flutter_bloc/flutter_bloc.dart';

class IsPlayingAyahCubit extends Cubit<bool> {
  IsPlayingAyahCubit() : super(false);

  void toggle() => emit(!state);
}