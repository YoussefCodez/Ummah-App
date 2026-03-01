import 'package:bloc/bloc.dart';

class SelectAyahCubit extends Cubit<String> {
  // الحالة الابتدائية هي نص فارغ (لا يوجد آية مختارة)
  SelectAyahCubit() : super("");

  // نختار الآية بناءً على رقم السورة ورقم الآية لضمان التفرد
  void selectAyah(int surah, int ayah) {
    emit("${surah}_$ayah");
  }

  // مسح التحديد
  void clearAyah() {
    emit("");
  }
}
