import 'package:islamic_azkar/islamic_azkar.dart';

abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoaded extends AzkarState {
  final List<Zekr> azkarList;
  final List<int> currentCounts;

  AzkarLoaded({required this.azkarList, required this.currentCounts});

  AzkarLoaded copyWith({List<Zekr>? azkarList, List<int>? currentCounts}) {
    return AzkarLoaded(
      azkarList: azkarList ?? this.azkarList,
      currentCounts: currentCounts ?? this.currentCounts,
    );
  }
}
