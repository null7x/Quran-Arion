import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_arion/providers/app_language_provider.dart';
import 'package:quran_arion/res/app_colors.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        backgroundColor: primaryColor,
      ),
      body: Consumer<AppLanguageProvider>(
        builder: (context, languageProvider, _) {
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                'Choose Your Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              _buildLanguageOption(
                context,
                flag: '🇬🇧',
                language: 'English',
                locale: Locale('en'),
                isSelected: languageProvider.locale.languageCode == 'en',
                onTap: () => languageProvider.setLocale(Locale('en')),
              ),
              SizedBox(height: 12),
              _buildLanguageOption(
                context,
                flag: '🇸🇦',
                language: 'العربية (Arabic)',
                locale: Locale('ar'),
                isSelected: languageProvider.locale.languageCode == 'ar',
                onTap: () => languageProvider.setLocale(Locale('ar')),
              ),
              SizedBox(height: 12),
              _buildLanguageOption(
                context,
                flag: '🇵🇰',
                language: 'اردو (Urdu)',
                locale: Locale('ur'),
                isSelected: languageProvider.locale.languageCode == 'ur',
                onTap: () => languageProvider.setLocale(Locale('ur')),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageOption(
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
