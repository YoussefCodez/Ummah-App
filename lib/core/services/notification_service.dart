abstract class NotificationService {
  Future<void> init();
  Future<void> requestPermissions();
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  });
  Future<void> firebaseMessaging();
}
