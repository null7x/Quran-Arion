# 🕌 Quran-Arion: Islamic Quran Application

A comprehensive Flutter application for Islamic Quran recitation, prayer times, and Islamic knowledge with complete BLoC architecture.

## ✨ Key Features

### 📖 Quran Access
- **All 114 Surahs** with complete Quranic text
- **8 Famous Reciters**: Abdul Basit, As-Sudais, Al-Tablawi, Alafasy, Al-Ghamdi, Al-Muaiqly, Al-Sisi, Al-Ajmi
- **Audio Playback** with play/stop controls
- **Favorites System** to save preferred Surahs

### 🕐 Prayer Times
- 5 Daily Prayers (Fajr, Dhuhr, Asr, Maghrib, Isha)
- Countdown timer to next prayer
- Location-based times (Moscow region)
- Daily prayer schedule

### 📿 Islamic Features
- **Daily Verse** - Verse of the Day with translations
- **Search** - Find Surahs by name/number or Qaris by name
- **Islamic Calendar** - Gregorian to Hijri date conversion
- **Duas Collection** - 10 Islamic supplications with categories
- **Qibla Compass** - Direction to Kaaba with compass display

### 👤 User Features
- **Personal Profile** with name and email
- **Statistics Tracking** - Surahs completed, listening hours, favorites
- **Streak Counter** - Daily consistency tracking
- **Recently Played** - History of accessed Surahs

## 🏗️ Architecture

### BLoC Pattern
- **14 BLoCs** implementing state management
- **11 Feature Tabs** with independent logic
- **Event-Driven** state updates
- **Async Operations** with loading states

### BLoCs Included
```
album_bloc           - Album management
boarding_bloc        - Onboarding flow
daily_verse_bloc     - Daily verse selection
duas_bloc            - Islamic supplications
favorites_bloc       - Favorite Surahs
home_bloc            - Main home screen
islamic_calendar_bloc- Islamic calendar
player_bloc          - Audio playback
prayer_times_bloc    - Prayer times
qari_playlist_bloc   - Reciter playlists
qibla_bloc           - Qibla direction
quran_bloc           - Quran Surahs
search_bloc          - Search functionality
user_profile_bloc    - User profile
```

## 🎨 Design

### Islamic Color Theme
- **Deep Green** (#0F3B2F) - Primary color
- **Gold** (#D4AF37) - Accent highlights
- **Dark Green** (#0B2F25) - Backgrounds
- **Cream** (#E8D5B7) - Text and highlights

### UI Components
- Card-based layouts
- Gradient backgrounds
- Expandable tiles
- Filter chips
- Progress indicators
- Avatar displays

## 📱 Navigation

11-Tab Bottom Navigation with:
1. 🎵 Recitations - Home audio interface
2. 👤 Reciters - Qari playlists
3. 📖 Quran - All 114 Surahs
4. 🧭 Qibla - Prayer direction
5. 🕌 Prayers - Prayer times
6. ❤️ Favorites - Saved Surahs
7. ✨ Verse - Daily verse
8. 🔍 Search - Find Surahs/Qaris
9. 📅 Calendar - Islamic calendar
10. 🤲 Duas - Islamic supplications
11. 👤 Profile - User profile & stats

## 🛠️ Technologies

- **Framework**: Flutter 3.x
- **State Management**: BLoC with Equatable
- **Audio**: just_audio package
- **Language**: Dart
- **Platform Support**: Android, iOS, Windows, Web

## 📋 Project Structure

```
lib/
├── bloc/                      # 14 BLoCs
│   ├── daily_verse_bloc/
│   ├── duas_bloc/
│   ├── favorites_bloc/
│   ├── islamic_calendar_bloc/
│   ├── prayer_times_bloc/
│   ├── search_bloc/
│   ├── user_profile_bloc/
│   └── ... (7 more)
├── view/                      # Feature Views
│   ├── daily_verse/
│   ├── duas/
│   ├── favorites/
│   ├── islamic_calendar/
│   ├── prayer_times/
│   ├── search/
│   ├── user_profile/
│   └── ... (8 more)
├── res/                       # Resources
│   ├── app_colors.dart
│   ├── app_icons.dart
│   ├── app_images.dart
│   └── app_svg.dart
├── model/                     # Data models
├── utils/                     # Utilities
├── db_helper/                 # Database
└── main.dart                  # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK
- Android SDK / Xcode (for platform builds)

### Installation

1. **Clone Repository**
   ```bash
   git clone <repository-url>
   cd Flutter-Music-Player-App-With-BLoc
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run Application**
   ```bash
   flutter run
   ```

4. **Build APK (Android)**
   ```bash
   flutter build apk --release
   ```

5. **Build IPA (iOS)**
   ```bash
   flutter build ios --release
   ```

## 📊 Data Models

### Prayer Times
- Name (Arabic and English)
- Time (HH:MM format)
- Next prayer countdown

### Favorites
- Surah number and name
- Date added
- Quick remove action

### Daily Verse
- Surah and Ayah number
- Arabic text
- English translation
- Russian translation
- Explanation

### Islamic Calendar
- Hijri month names (12 months)
- Day names
- 9 Important Islamic holidays
- Gregorian↔Hijri conversion

### Duas
- 10 Islamic supplications
- 8 categories
- Arabic text
- Multi-language translations
- Benefits explanation

### User Profile
- Name and email
- Statistics (Surahs, hours, favorites)
- Streak counter
- Member since date
- Recently played history

## ✅ Features Checklist

- [x] All 114 Surahs
- [x] 8 Famous reciters
- [x] Audio playback
- [x] Favorites system
- [x] Prayer times (5 prayers)
- [x] Daily verse
- [x] Search functionality
- [x] Islamic calendar
- [x] Duas collection (10 duas)
- [x] User profile
- [x] Qibla compass
- [x] BLoC pattern architecture
- [x] Islamic theme design
- [x] 11 navigation tabs
- [x] Complete documentation

## 📝 Git History

```
dcae698 - docs: Add implementation summary with project completion status
8cc6370 - docs: Add comprehensive feature documentation for Quran-Arion app
3831f3d - feat: Add all Islamic features (7 new features)
940fc6f - Add Qari Playlists feature
1704370 - Add Qibla Compass feature
5fd48f0 - Update Quran Surahs (all 114 chapters)
f7ff018 - Add Now Playing widget
...
```

## 📄 Documentation

- **FEATURES.md** - Comprehensive feature list
- **IMPLEMENTATION_SUMMARY.md** - Project completion status
- **README.md** - This file

## 🔐 Package Information

- **Package Name**: quran_arion
- **Android Package ID**: com.null7x.quran_arion
- **iOS Bundle Name**: Quran-Arion
- **Version**: 1.0.0

## 🌍 Supported Languages

- English
- Russian
- Arabic (Quranic text)

## 📧 Contact & Support

For feature requests or issues, please refer to project documentation.

## 📜 License

This project is created for educational and religious purposes.

---

**Status**: ✅ Complete and Ready for Deployment
**Last Updated**: Implementation Complete
**Version**: 1.0.0-complete
