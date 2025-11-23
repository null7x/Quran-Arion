import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<EnablePrayerNotificationsEvent>(_onEnablePrayerNotifications);
    on<DisablePrayerNotificationsEvent>(_onDisablePrayerNotifications);
    on<ScheduleNotificationEvent>(_onScheduleNotification);
    on<CancelNotificationEvent>(_onCancelNotification);
    on<SendDailyVerseNotificationEvent>(_onSendDailyVerseNotification);
    on<TogglePrayerAlertEvent>(_onTogglePrayerAlert);
  }

  Future<void> _onLoadNotifications(
      LoadNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(status: NotificationStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        notifications: _getDefaultNotifications(),
        status: NotificationStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onEnablePrayerNotifications(
      EnablePrayerNotificationsEvent event, Emitter<NotificationState> emit) async {
    try {
      final updatedPreferences = state.preferences.copyWith(prayerNotifications: true);
      emit(state.copyWith(preferences: updatedPreferences));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onDisablePrayerNotifications(
      DisablePrayerNotificationsEvent event, Emitter<NotificationState> emit) async {
    try {
      final updatedPreferences = state.preferences.copyWith(prayerNotifications: false);
      emit(state.copyWith(preferences: updatedPreferences));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onScheduleNotification(
      ScheduleNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      final newNotification = Notification(
        id: state.notifications.length + 1,
        title: event.title,
        body: event.body,
        scheduledTime: event.scheduledTime,
        isRead: false,
        type: 'custom',
      );
      final updatedNotifications = [...state.notifications, newNotification];
      emit(state.copyWith(
        notifications: updatedNotifications,
        unreadCount: state.unreadCount + 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onCancelNotification(
      CancelNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      final updatedNotifications =
          state.notifications.where((n) => n.id != event.notificationId).toList();
      emit(state.copyWith(notifications: updatedNotifications));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onSendDailyVerseNotification(
      SendDailyVerseNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      final dailyVerse = Notification(
        id: state.notifications.length + 1,
        title: 'Daily Verse',
        body: 'Your daily Islamic wisdom awaits.',
        scheduledTime: DateTime.now(),
        isRead: false,
        type: 'verse',
      );
      final updatedNotifications = [...state.notifications, dailyVerse];
      emit(state.copyWith(
        notifications: updatedNotifications,
        unreadCount: state.unreadCount + 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onTogglePrayerAlert(
      TogglePrayerAlertEvent event, Emitter<NotificationState> emit) async {
    try {
      final updatedAlerts = Map<String, bool>.from(state.preferences.prayerAlerts);
      updatedAlerts[event.prayerName] = !(updatedAlerts[event.prayerName] ?? true);
      final updatedPreferences = state.preferences.copyWith(prayerAlerts: updatedAlerts);
      emit(state.copyWith(preferences: updatedPreferences));
    } catch (e) {
      emit(state.copyWith(
        status: NotificationStatus.error,
        error: e.toString(),
      ));
    }
  }

  List<Notification> _getDefaultNotifications() {
    return [
      Notification(
        id: 1,
        title: 'Prayer Time - Fajr',
        body: 'Time for Fajr prayer - 05:45 AM',
        scheduledTime: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
        type: 'prayer',
      ),
      Notification(
        id: 2,
        title: 'Daily Verse',
        body: 'Your daily Islamic wisdom is ready',
        scheduledTime: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
        type: 'verse',
      ),
    ];
  }
}
