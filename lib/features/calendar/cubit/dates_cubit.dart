import 'package:bloc/bloc.dart';

class EnglishDatesCubit extends Cubit<String> {
  EnglishDatesCubit() : super("");

  void getEnglishDate(String date){
    emit(date);
  }

}

class HijriDatesCubit extends Cubit<String> {
  HijriDatesCubit() : super("");

  void getHijriDate(String date){
    emit(date);
  }

}
