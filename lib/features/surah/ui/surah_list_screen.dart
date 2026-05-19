
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/arabic_numbers.dart';
import '../cubit/surah_cubit.dart';
import '../cubit/surah_state.dart';
import 'surah_reader_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<SurahCubit>().getSurahs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

    if (value.trim().isEmpty) {
      return 'غير محدد';
    }

    return value;
  }

  List<dynamic> _filterSurahs(List<dynamic> surahs) {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) return surahs;

    return surahs.where((surah) {
      final arabicName = surah.name.toString();
      final englishName = surah.englishName.toString().toLowerCase();
      final number = surah.number.toString();

      return arabicName.contains(query) ||
          englishName.contains(query) ||
          number == query;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('القرآن الكريم'),
        ),
        body: BlocBuilder<SurahCubit, SurahState>(
          builder: (context, state) {
            if (state.status == SurahStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == SurahStatus.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    state.errorMessage ?? 'حدث خطأ أثناء تحميل السور',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }

            if (state.surahs.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد سور متاحة حاليًا',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            final filteredSurahs = _filterSurahs(state.surahs);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'ابحث باسم السورة أو رقمها',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: filteredSurahs.isEmpty
                      ? const Center(
                    child: Text(
                      'لا توجد نتائج مطابقة للبحث',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredSurahs.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final surah = filteredSurahs[index];

                      final surahName =
                      surah.name.toString().trim().isNotEmpty
                          ? surah.name.toString()
                          : 'سورة رقم ${ArabicNumbers.convert(surah.number)}';

                      final revelationPlace = _revelationPlaceAr(
                        surah.revelationType.toString(),
                      );

                      final ayahsCount = ArabicNumbers.convert(
                        surah.numberOfAyahs,
                      );

                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              ArabicNumbers.convert(surah.number),
                            ),
                          ),
                          title: Text(
                            surahName,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '$revelationPlace • $ayahsCount آية',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.color,
                              ),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SurahReaderScreen(
                                  surahNumber: surah.number,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/arabic_numbers.dart';
import '../cubit/surah_cubit.dart';
import '../cubit/surah_state.dart';
import 'surah_reader_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SurahCubit>().getSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('القرآن الكريم'),
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

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.surahs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final surah = state.surahs[index];

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        ArabicNumbers.convert(surah.number),
                      ),
                    ),
                    title: Text(
                      surah.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${surah.revelationType == 'Meccan' || surah.revelationType == 'مكية' ? 'مكية' : 'مدنية'} • ${ArabicNumbers.convert(surah.numberOfAyahs)} آية',
                    ),
                    trailing: const Icon(Icons.arrow_back_ios_new_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SurahReaderScreen(
                            surahNumber: surah.number,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/