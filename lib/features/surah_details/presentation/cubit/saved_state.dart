part of 'saved_cubit.dart';

@immutable
sealed class SavedState {}

final class SavedInitial extends SavedState {}

final class SavedLoading extends SavedState {}

final class SavedSuccess extends SavedState {
  final Map<int, SavedPageEntity> savedPages;
  SavedSuccess({required this.savedPages});
}

final class SavedFailure extends SavedState {
  final String message;
  SavedFailure(this.message);
}
