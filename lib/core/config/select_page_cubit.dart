import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPageCubit extends Cubit<int> {
  SelectPageCubit() : super(0);
  void selectPage(int page) {
    emit(page);
  }
}