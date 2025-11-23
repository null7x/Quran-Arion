abstract class NotificationEvent {}

class LoadNotificationsEvent extends NotificationEvent {}

class EnablePrayerNotificationsEvent extends NotificationEvent {}

class DisablePrayerNotificationsEvent extends NotificationEvent {}

class ScheduleNotificationEvent extends NotificationEvent {
  final String title;
  final String body;
  final DateTime scheduledTime;
  ScheduleNotificationEvent({
    required this.title,
    required this.body,
    required this.scheduledTime,
  });
}

class CancelNotificationEvent extends NotificationEvent {
  final int notificationId;
  CancelNotificationEvent(this.notificationId);
}

class SendDailyVerseNotificationEvent extends NotificationEvent {}

class TogglePrayerAlertEvent extends NotificationEvent {
  final String prayerName;
  TogglePrayerAlertEvent(this.prayerName);
}
