
# Quran Reader & Audio App

A professional Flutter Quran application for reading the Holy Quran with Uthmani-style Arabic text, listening to Quran recitations, viewing meanings, translations, and Arabic tafsir.

The app is built using a clean feature-based architecture with Cubit state management, Dio for API requests, Hive for local caching, and Just Audio for Quran audio playback.

---

## App Name

**Quran Reader & Audio**

Suggested Flutter package name:

# Overview
This Flutter application provides a clean and user-friendly Quran reading experience.
It allows users to browse all Surahs,
read Quran text in Arabic with Uthmani-style formatting and verse numbers,
listen to recitations, and view meanings, translations, and tafsir.
The project is organized using a scalable architecture that separates core services,
Surah reading logic, audio/media features, UI screens, repositories,
data sources, models, widgets, and Cubit state management.

# Features
* Display a complete list of the 114 Quran Surahs.
* Show Surah name, Surah number, number of verses, and revelation place.
* Read Surahs in Arabic with Uthmani-style Quran text.
* Display Quran text with full Arabic diacritics where available.
* Display verse numbers using Arabic numerals.
* Display Basmala where applicable.
* Navigate between previous and next Surahs.
* Search Surahs by Arabic name, English name, or Surah number.
* Listen to Quran recitations using selected reciters.
* Play the full Surah audio.
* Pause, resume, and stop audio playback.
* Play a selected range of verses.
* View meanings, translations, and Arabic tafsir.
* Support light and dark themes.
* Cache Surah data locally using Hive.
* Handle errors using a clean Failure-based structure.
* Separate Quran reading feature from audio, meanings, translations, and tafsir feature.

# Core Technologies
* Flutter
* Dart
* Cubit / flutter_bloc
* Dio
* Hive / hive_flutter
* Just Audio
* Equatable
* Material Design

# Architecture

The project follows a feature-based clean structure.

Main layers:

* core: shared app services, constants, theme, audio player, error handling, utilities.
* features/surah: Surah list, Quran reader, Surah models, Surah repository, Surah Cubit.
* features/quran_media: audio recitation, meanings, translations, tafsir, Quran media Cubit.
* data: remote and local data sources.
* repositories: abstraction layer between Cubit and data sources.
* models: data models.
* ui: screens.
* widgets: reusable UI components.

# SurahCubit

Responsible for:

* Loading the list of Surahs.
* Loading a selected Surah.
* Handling Surah loading states.
* Handling Surah errors.
* Providing Quran reading data to the UI.
* Supporting light and dark themes.
* Caching Surah data locally using Hive.
  lib/features/surah/cubit/surah_cubit.dart
  lib/features/surah/cubit/surah_state.dart

# QuranMediaCubit

Responsible for:

* Loading audio recitation links.
* Managing the selected reciter.
* Playing full Surah audio.
* Playing selected verse ranges.
* Pausing audio.
* Resuming audio.
* Stopping audio.
* Loading meanings.
* Loading translations.
* Loading tafsir.
* Managing media loading, success, and failure states.

Files:

lib/features/quran_media/cubit/quran_media_cubit.dart
lib/features/quran_media/cubit/quran_media_state.dart

1. QuranAPI

Used for:

* Surah list.
* Surah details.
* Quran Arabic text.
* Uthmani-style Quran reading display.

Base URL:

https://quranapi.pages.dev/api

Main endpoints:

GET /surah.json
GET /{surahNumber}.json

Examples:

https://quranapi.pages.dev/api/surah.json
https://quranapi.pages.dev/api/1.json

Used inside:

lib/features/surah/data/surah_remote_data_source.dart 

2. AlQuran Cloud API

Used for:

* Quran audio recitations.
* Quran meanings.
* Quran translations.
* Arabic tafsir editions.

Base URL:

https://api.alquran.cloud/v1

Main endpoints:

GET /surah/{surahNumber}/{edition}
GET /edition/type/tafsir

Examples:

https://api.alquran.cloud/v1/surah/1/ar.alafasy
https://api.alquran.cloud/v1/surah/1/en.sahih
https://api.alquran.cloud/v1/edition/type/tafsir

Used inside:

lib/features/quran_media/data/quran_media_remote_data_source.dart

```yaml
name: quran_reader_audio
description: A Flutter Quran app with Uthmani text, audio recitation, meanings, translations, and tafsir.

# Folder Structure
lib/
│
├── core/
│   ├── api/
│   │   ├── api_constants.dart
│   │   └── dio_client.dart
│   │
│   ├── audio/
│   │   └── quran_audio_player.dart
│   │
│   ├── errors/
│   │   └── failures.dart
│   │
│   ├── theme/
│   │   └── app_theme.dart
│   │
│   └── utils/
│       └── arabic_numbers.dart
│
├── features/
│   │
│   ├── surah/
│   │   ├── cubit/
│   │   │   ├── surah_cubit.dart
│   │   │   └── surah_state.dart
│   │   │
│   │   ├── data/
│   │   │   ├── surah_local_data_source.dart
│   │   │   └── surah_remote_data_source.dart
│   │   │
│   │   ├── models/
│   │   │   ├── ayah_model.dart
│   │   │   └── surah_model.dart
│   │   │
│   │   ├── repositories/
│   │   │   ├── surah_repository.dart
│   │   │   └── surah_repository_impl.dart
│   │   │
│   │   ├── ui/
│   │   │   ├── surah_list_screen.dart
│   │   │   └── surah_reader_screen.dart
│   │   │
│   │   └── widgets/
│   │       ├── ayah_card.dart
│   │       ├── surah_page_header.dart
│   │       └── surah_page_navigation.dart
│   │
│   └── quran_media/
│       ├── cubit/
│       │   ├── quran_media_cubit.dart
│       │   └── quran_media_state.dart
│       │
│       ├── data/
│       │   └── quran_media_remote_data_source.dart
│       │
│       ├── repositories/
│       │   ├── quran_media_repository.dart
│       │   └── quran_media_repository_impl.dart
│       │
│       ├── ui/
│       │   └── quran_media_screen.dart
│       │
│       └── widgets/
│           └── edition_selector.dart
│
└── main.dart
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

