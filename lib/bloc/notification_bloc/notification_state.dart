enum NotificationStatus { initial, loading, success, error }

class Notification {
  final int id;
  final String title;
  final String body;
  final DateTime scheduledTime;
  final bool isRead;
  final String type; // prayer, verse, reminder, etc.

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.isRead,
    required this.type,
  });

  Notification copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? scheduledTime,
    bool? isRead,
    String? type,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
}

class NotificationPreferences {
  final bool prayerNotifications;
  final bool verseNotifications;
  final bool generalNotifications;
  final Map<String, bool> prayerAlerts; // Fajr, Dhuhr, Asr, Maghrib, Isha
  final int notificationHours;
  final int notificationMinutes;

  NotificationPreferences({
    this.prayerNotifications = true,
    this.verseNotifications = true,
    this.generalNotifications = true,
    this.prayerAlerts = const {
      'Fajr': true,
      'Dhuhr': true,
      'Asr': true,
      'Maghrib': true,
      'Isha': true,
    },
    this.notificationHours = 0,
    this.notificationMinutes = 0,
  });

  NotificationPreferences copyWith({
    bool? prayerNotifications,
    bool? verseNotifications,
    bool? generalNotifications,
    Map<String, bool>? prayerAlerts,
    int? notificationHours,
    int? notificationMinutes,
  }) {
    return NotificationPreferences(
      prayerNotifications: prayerNotifications ?? this.prayerNotifications,
      verseNotifications: verseNotifications ?? this.verseNotifications,
      generalNotifications: generalNotifications ?? this.generalNotifications,
      prayerAlerts: prayerAlerts ?? this.prayerAlerts,
      notificationHours: notificationHours ?? this.notificationHours,
      notificationMinutes: notificationMinutes ?? this.notificationMinutes,
    );
  }
}

class NotificationState {
  final List<Notification> notifications;
  final NotificationPreferences preferences;
  final NotificationStatus status;
  final String? error;
  final int unreadCount;

  NotificationState({
    this.notifications = const [],
    this.preferences = const NotificationPreferences(),
    this.status = NotificationStatus.initial,
    this.error,
    this.unreadCount = 0,
  });

  NotificationState copyWith({
    List<Notification>? notifications,
    NotificationPreferences? preferences,
    NotificationStatus? status,
    String? error,
    int? unreadCount,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      preferences: preferences ?? this.preferences,
      status: status ?? this.status,
      error: error ?? this.error,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
