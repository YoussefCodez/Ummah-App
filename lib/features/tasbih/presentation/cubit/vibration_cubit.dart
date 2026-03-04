import 'package:bloc/bloc.dart';

class VibrationCubit extends Cubit<bool> {
  VibrationCubit() : super(true);

  void toggleVibration() {
    emit(!state);
  }
}
