import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/notification_bloc/notification_bloc.dart';
import '../../bloc/notification_bloc/notification_event.dart';
import '../../bloc/notification_bloc/notification_state.dart';
import '../../res/app_colors.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(LoadNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.darkGreen,
        elevation: 0,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Prayer Notifications',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Enable All Notifications'),
                        value: state.preferences.prayerNotifications,
                        onChanged: (value) {
                          if (value) {
                            context
                                .read<NotificationBloc>()
                                .add(EnablePrayerNotificationsEvent());
                          } else {
                            context
                                .read<NotificationBloc>()
                                .add(DisablePrayerNotificationsEvent());
                          }
                        },
                        activeColor: AppColors.darkGreen,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Specific Prayer Alerts',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      ...['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'].map((prayer) {
                        final isEnabled = state.preferences.prayerAlerts[prayer] ?? true;
                        return SwitchListTile(
                          title: Text(prayer),
                          subtitle: Text('Notify at prayer time'),
                          value: isEnabled,
                          onChanged: (value) {
                            context
                                .read<NotificationBloc>()
                                .add(TogglePrayerAlertEvent(prayer));
                          },
                          activeColor: AppColors.darkGreen,
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      const Text(
                        'Other Notifications',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Daily Verse'),
                        subtitle: const Text('Get daily Islamic wisdom'),
                        value: state.preferences.verseNotifications,
                        onChanged: (value) {},
                        activeColor: AppColors.darkGreen,
                      ),
                      SwitchListTile(
                        title: const Text('General Notifications'),
                        value: state.preferences.generalNotifications,
                        onChanged: (value) {},
                        activeColor: AppColors.darkGreen,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Recent Notifications',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                ...state.notifications.map((notification) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notification.body,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatTime(notification.scheduledTime),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
