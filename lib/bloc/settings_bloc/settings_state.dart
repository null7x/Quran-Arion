part of 'settings_bloc.dart';

class AppSettings {
  final bool isDarkMode;
  final double fontSize;
  final String language;
  final bool notificationsEnabled;
  final bool offlineMode;

  const AppSettings({
    this.isDarkMode = false,
    this.fontSize = 16.0,
    this.language = 'en',
    this.notificationsEnabled = true,
    this.offlineMode = false,
  });

  AppSettings copyWith({
    bool? isDarkMode,
    double? fontSize,
    String? language,
    bool? notificationsEnabled,
    bool? offlineMode,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      fontSize: fontSize ?? this.fontSize,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      offlineMode: offlineMode ?? this.offlineMode,
    );
  }
}

class SettingsState extends Equatable {
  final AppSettings settings;
  final Status status;

  const SettingsState({
    AppSettings? settings,
    this.status = Status.initial,
  }) : settings = settings ?? const AppSettings();

  SettingsState copyWith({
    AppSettings? settings,
    Status? status,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [settings, status];
}

enum Status { initial, loading, complete, error }
