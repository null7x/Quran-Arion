part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends SettingsEvent {
  final bool isDarkMode;
  
  const ToggleThemeEvent(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

class ChangeFontSizeEvent extends SettingsEvent {
  final double fontSize;
  
  const ChangeFontSizeEvent(this.fontSize);

  @override
  List<Object> get props => [fontSize];
}

class ChangeLanguageEvent extends SettingsEvent {
  final String language;
  
  const ChangeLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

class SetNotificationsEvent extends SettingsEvent {
  final bool enabled;
  
  const SetNotificationsEvent(this.enabled);

  @override
  List<Object> get props => [enabled];
}
