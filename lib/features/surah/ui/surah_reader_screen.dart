
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/arabic_numbers.dart';
import '../../quran_media/ui/quran_media_screen.dart';
import '../cubit/surah_cubit.dart';
import '../cubit/surah_state.dart';
import '../widgets/ayah_card.dart';
import '../widgets/surah_page_header.dart';
import '../widgets/surah_page_navigation.dart';

class SurahReaderScreen extends StatefulWidget {
  final int surahNumber;

  const SurahReaderScreen({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends State<SurahReaderScreen> {
  late int currentSurah;

  @override
  void initState() {
    super.initState();
    currentSurah = widget.surahNumber;
    context.read<SurahCubit>().getSurahByNumber(currentSurah);
  }

  void _goToSurah(int number) {
    setState(() {
      currentSurah = number;
    });

    context.read<SurahCubit>().getSurahByNumber(number);
  }

  String _revelationPlaceAr(String value) {
    final normalized = value.trim().toLowerCase();

    if (normalized == 'mecca' ||
        normalized == 'makkah' ||
        normalized == 'meccan' ||
        value == 'مكية') {
      return 'مكية';
    }

    if (normalized == 'madina' ||
        normalized == 'medina' ||
        normalized == 'medinan' ||
        value == 'مدنية') {
      return 'مدنية';
    }

    return value;
  }

  void _openMediaScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuranMediaScreen(
          surahNumber: currentSurah,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<SurahCubit, SurahState>(
        builder: (context, state) {
          final surah = state.selectedSurah;

          final appBarTitle = surah == null
              ? 'تحميل السورة...'
              : '${surah.name} • ${ArabicNumbers.convert(surah.numberOfAyahs)} آية';

          return Scaffold(
            appBar: AppBar(
              title: Text(
                appBarTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'الأصوات والمعاني والتفاسير',
                  onPressed: _openMediaScreen,
                  icon: const Icon(Icons.menu_book_rounded),
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state.status == SurahStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.status == SurahStatus.failure) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'حدث خطأ أثناء تحميل السورة',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (surah == null) {
                  return const SizedBox.shrink();
                }

                final revelationPlace = _revelationPlaceAr(
                  surah.revelationType,
                );

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: surah.ayahs.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return SurahPageHeader(
                              surah: surah,
                              revelationPlace: revelationPlace,
                              onMediaPressed: _openMediaScreen,
                            );
                          }

                          return AyahCard(
                            ayah: surah.ayahs[index - 1],
                          );
                        },
                      ),
                    ),
                    SurahPageNavigation(
                      currentSurah: currentSurah,
                      onPrevious: () => _goToSurah(currentSurah - 1),
                      onNext: () => _goToSurah(currentSurah + 1),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/surah_cubit.dart';
import '../cubit/surah_state.dart';
import '../widgets/ayah_card.dart';
import '../widgets/surah_page_header.dart';
import '../widgets/surah_page_navigation.dart';

class SurahReaderScreen extends StatefulWidget {
  final int surahNumber;

  const SurahReaderScreen({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahReaderScreen> createState() => _SurahReaderScreenState();
}

class _SurahReaderScreenState extends State<SurahReaderScreen> {
  late int currentSurah;

  @override
  void initState() {
    super.initState();
    currentSurah = widget.surahNumber;
    context.read<SurahCubit>().getSurahByNumber(currentSurah);
  }

  void _goToSurah(int number) {
    setState(() => currentSurah = number);
    context.read<SurahCubit>().getSurahByNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قراءة السورة'),
        ),
        body: BlocBuilder<SurahCubit, SurahState>(
          builder: (context, state) {
            if (state.status == SurahStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == SurahStatus.failure) {
              return Center(
                child: Text(state.errorMessage ?? 'حدث خطأ'),
              );
            }

            final surah = state.selectedSurah;

            if (surah == null) {
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: surah.ayahs.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return SurahPageHeader(surah: surah);
                      }

                      return AyahCard(
                        ayah: surah.ayahs[index - 1],
                      );
                    },
                  ),
                ),
                SurahPageNavigation(
                  currentSurah: currentSurah,
                  onPrevious: () => _goToSurah(currentSurah - 1),
                  onNext: () => _goToSurah(currentSurah + 1),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
*/