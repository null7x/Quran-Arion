import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/bloc/settings_bloc/settings_bloc.dart';
import 'package:quran_arion/providers/app_language_provider.dart';
import 'package:quran_arion/res/app_colors.dart';
import 'package:quran_arion/utils/translations.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const LoadSettingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueBackground,
      appBar: AppBar(
        title: Text(context.tr('settings')),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Theme Section
              _buildSectionTitle(context, context.tr('appearance')),
              const SizedBox(height: 12),
              _buildSwitchTile(
                context,
                context.tr('darkMode'),
                'Enable dark theme',
                Icons.dark_mode,
                state.settings.isDarkMode,
                (value) {
                  context.read<SettingsBloc>().add(ToggleThemeEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // Font Size Section
              _buildSectionTitle(context, context.tr('textSettings')),
              const SizedBox(height: 12),
              _buildSliderTile(
                context,
                context.tr('fontSize'),
                state.settings.fontSize,
                12,
                24,
                (value) {
                  context.read<SettingsBloc>().add(ChangeFontSizeEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // Language Section
              _buildSectionTitle(context, context.tr('language')),
              const SizedBox(height: 12),
              Consumer<AppLanguageProvider>(
                builder: (context, languageProvider, _) {
                  return _buildLanguageOptions(context, languageProvider);
                },
              ),
              const SizedBox(height: 24),

              // Notifications Section
              _buildSectionTitle(context, context.tr('notifications')),
              const SizedBox(height: 12),
              _buildSwitchTile(
                context,
                context.tr('prayerNotifications'),
                'Receive prayer time reminders',
                Icons.notifications_active,
                state.settings.notificationsEnabled,
                (value) {
                  context.read<SettingsBloc>().add(SetNotificationsEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // About Section
              _buildSectionTitle(context, context.tr('about')),
              const SizedBox(height: 12),
              _buildInfoTile(
                context,
                context.tr('version'),
                '1.0.0-complete',
                Icons.info_outline,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.blueShade,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.blueShade),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.lightShadowColor,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.shadowColor,
              ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.blueShade,
        ),
      ),
    );
  }

  Widget _buildSliderTile(
    BuildContext context,
    String title,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.lightShadowColor,
                    ),
              ),
              Text(
                '${value.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.blueShade,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppColors.blueShade,
            inactiveColor: AppColors.shadowColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    BuildContext context,
    String title,
    String value,
    List<String> items,
    List<String> labels,
    Function(String) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: AppColors.backgroundColor,
        underline: Container(),
        items: items.asMap().entries.map((entry) {
          return DropdownMenuItem(
            value: entry.value,
            child: Text(
              labels[entry.key],
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.lightShadowColor,
                  ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String title,
    String info,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.blueShade, width: 1),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.blueShade),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.lightShadowColor,
              ),
        ),
        trailing: Text(
          info,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.shadowColor,
              ),
        ),
      ),
    );
  }

  Widget _buildLanguageOptions(
    BuildContext context,
    AppLanguageProvider languageProvider,
  ) {
    return Column(
      children: [
        _buildLanguageButton(
          context,
          flag: '🇬🇧',
          language: 'English',
          locale: Locale('en'),
          isSelected: languageProvider.locale.languageCode == 'en',
          onTap: () => languageProvider.setLocale(Locale('en')),
        ),
        SizedBox(height: 10),
        _buildLanguageButton(
          context,
          flag: '🇸🇦',
          language: 'العربية',
          locale: Locale('ar'),
          isSelected: languageProvider.locale.languageCode == 'ar',
          onTap: () => languageProvider.setLocale(Locale('ar')),
        ),
        SizedBox(height: 10),
        _buildLanguageButton(
          context,
          flag: '🇵🇰',
          language: 'اردو',
          locale: Locale('ur'),
          isSelected: languageProvider.locale.languageCode == 'ur',
          onTap: () => languageProvider.setLocale(Locale('ur')),
        ),
        SizedBox(height: 10),
        _buildLanguageButton(
          context,
          flag: '🇷🇺',
          language: 'Русский',
          locale: Locale('ru'),
          isSelected: languageProvider.locale.languageCode == 'ru',
          onTap: () => languageProvider.setLocale(Locale('ru')),
        ),
      ],
    );
  }

  Widget _buildLanguageButton(
    BuildContext context, {
    required String flag,
    required String language,
    required Locale locale,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.blueShade.withOpacity(0.2)
              : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.blueShade : Colors.grey[700]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 24)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.blueShade : AppColors.shadowColor,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.blueShade,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
