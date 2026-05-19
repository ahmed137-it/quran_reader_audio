
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/api/dio_client.dart';
import 'core/audio/quran_audio_player.dart';
import 'core/theme/app_theme.dart';

import 'features/surah/cubit/surah_cubit.dart';
import 'features/surah/data/surah_local_data_source.dart';
import 'features/surah/data/surah_remote_data_source.dart';
import 'features/surah/repositories/surah_repository_impl.dart';
import 'features/surah/ui/surah_list_screen.dart';

import 'features/quran_media/cubit/quran_media_cubit.dart';
import 'features/quran_media/data/quran_media_remote_data_source.dart';
import 'features/quran_media/repositories/quran_media_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // استخدمه مرة واحدة فقط لمسح الكاش القديم، ثم احذفه أو علّقه
  // await Hive.deleteBoxFromDisk('surah_box');

  final dioClient = DioClient();

  final surahRepository = SurahRepositoryImpl(
    remote: SurahRemoteDataSource(dioClient.dio),
    local: SurahLocalDataSource(),
  );

  final quranMediaRepository = QuranMediaRepositoryImpl(
    remote: QuranMediaRemoteDataSource(dioClient.dio),
  );

  runApp(
    QuranApp(
      surahRepository: surahRepository,
      quranMediaRepository: quranMediaRepository,
    ),
  );
}

class QuranApp extends StatelessWidget {
  final SurahRepositoryImpl surahRepository;
  final QuranMediaRepositoryImpl quranMediaRepository;

  const QuranApp({
    super.key,
    required this.surahRepository,
    required this.quranMediaRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SurahCubit>(
          create: (_) => SurahCubit(surahRepository),
        ),
        BlocProvider<QuranMediaCubit>(
          create: (_) => QuranMediaCubit(
            repository: quranMediaRepository,
            audioPlayer: QuranAudioPlayer(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'القرآن الكريم',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        home: const SurahListScreen(),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/api/dio_client.dart';
import 'core/theme/app_theme.dart';
import 'features/surah/cubit/surah_cubit.dart';
import 'features/surah/data/surah_local_data_source.dart';
import 'features/surah/data/surah_remote_data_source.dart';
import 'features/surah/repositories/surah_repository_impl.dart';
import 'features/surah/ui/surah_list_screen.dart';
import 'features/quran_media/cubit/quran_media_cubit.dart';
import 'features/quran_media/data/quran_media_remote_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // مؤقت فقط لمسح البيانات القديمة
  await Hive.deleteBoxFromDisk('surah_box');

  final dioClient = DioClient();

  final surahRepository = SurahRepositoryImpl(
    remote: SurahRemoteDataSource(dioClient.dio),
    local: SurahLocalDataSource(),
  );

  runApp(
    QuranApp(
      dioClient: dioClient,
      surahRepository: surahRepository,
    ),
  );
}

class QuranApp extends StatelessWidget {
  final DioClient dioClient;
  final SurahRepositoryImpl surahRepository;

  const QuranApp({
    super.key,
    required this.dioClient,
    required this.surahRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SurahCubit(surahRepository),
        ),
        BlocProvider(
          create: (_) => QuranMediaCubit(
            QuranMediaRemoteDataSource(dioClient.dio),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'القرآن الكريم',
        theme: AppTheme.light(),
       // theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        home: const SurahListScreen(),
      ),
    );
  }
}
*/