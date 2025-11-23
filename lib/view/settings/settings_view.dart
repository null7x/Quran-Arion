import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_arion/bloc/settings_bloc/settings_bloc.dart';
import 'package:quran_arion/res/app_colors.dart';

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
        title: const Text('Settings'),
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
              _buildSectionTitle(context, 'Appearance'),
              const SizedBox(height: 12),
              _buildSwitchTile(
                context,
                'Dark Mode',
                'Enable dark theme',
                Icons.dark_mode,
                state.settings.isDarkMode,
                (value) {
                  context.read<SettingsBloc>().add(ToggleThemeEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // Font Size Section
              _buildSectionTitle(context, 'Text Settings'),
              const SizedBox(height: 12),
              _buildSliderTile(
                context,
                'Font Size',
                state.settings.fontSize,
                12,
                24,
                (value) {
                  context.read<SettingsBloc>().add(ChangeFontSizeEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // Language Section
              _buildSectionTitle(context, 'Language'),
              const SizedBox(height: 12),
              _buildDropdownTile(
                context,
                'Select Language',
                state.settings.language,
                ['en', 'ru', 'ar'],
                ['English', 'Русский', 'العربية'],
                (value) {
                  context.read<SettingsBloc>().add(ChangeLanguageEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // Notifications Section
              _buildSectionTitle(context, 'Notifications'),
              const SizedBox(height: 12),
              _buildSwitchTile(
                context,
                'Prayer Notifications',
                'Receive prayer time reminders',
                Icons.notifications_active,
                state.settings.notificationsEnabled,
                (value) {
                  context.read<SettingsBloc>().add(SetNotificationsEvent(value));
                },
              ),
              const SizedBox(height: 24),

              // About Section
              _buildSectionTitle(context, 'About'),
              const SizedBox(height: 12),
              _buildInfoTile(
                context,
                'Version',
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
}
