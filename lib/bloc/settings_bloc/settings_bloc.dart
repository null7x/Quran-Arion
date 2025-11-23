import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<ChangeFontSizeEvent>(_onChangeFontSize);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<SetNotificationsEvent>(_onSetNotifications);
  }

  Future<void> _onLoadSettings(
      LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Load from local storage (currently using defaults)
      emit(state.copyWith(status: Status.complete));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onToggleTheme(
      ToggleThemeEvent event, Emitter<SettingsState> emit) async {
    try {
      final updated = state.settings.copyWith(isDarkMode: event.isDarkMode);
      emit(state.copyWith(settings: updated));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onChangeFontSize(
      ChangeFontSizeEvent event, Emitter<SettingsState> emit) async {
    try {
      final updated = state.settings.copyWith(fontSize: event.fontSize);
      emit(state.copyWith(settings: updated));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<SettingsState> emit) async {
    try {
      final updated = state.settings.copyWith(language: event.language);
      emit(state.copyWith(settings: updated));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> _onSetNotifications(
      SetNotificationsEvent event, Emitter<SettingsState> emit) async {
    try {
      final updated = state.settings.copyWith(notificationsEnabled: event.enabled);
      emit(state.copyWith(settings: updated));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
