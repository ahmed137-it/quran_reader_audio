
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/api_constants.dart';
import '../cubit/quran_media_cubit.dart';
import '../cubit/quran_media_state.dart';
import '../widgets/edition_selector.dart';

class QuranMediaScreen extends StatelessWidget {
  final int surahNumber;

  const QuranMediaScreen({
    super.key,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأصوات والمعاني والتفاسير'),
        ),
        body: BlocBuilder<QuranMediaCubit, QuranMediaState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                EditionSelector(
                  title: 'اختر القارئ',
                  value: state.selectedReciter,
                  items: ApiConstants.recitersAr,
                  onChanged: (edition) {
                    context.read<QuranMediaCubit>().loadAudio(
                      surahNumber: surahNumber,
                      reciter: edition,
                    );
                  },
                ),
                const SizedBox(height: 12),
                //------
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              context.read<QuranMediaCubit>().playFullSurahAudio();
                            },
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('السورة كاملة'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              context.read<QuranMediaCubit>().pauseAudio();
                            },
                            icon: const Icon(Icons.pause_rounded),
                            label: const Text('إيقاف مؤقت'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              context.read<QuranMediaCubit>().resumeAudio();
                            },
                            icon: const Icon(Icons.replay_rounded),
                            label: const Text('استكمال'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              context.read<QuranMediaCubit>().stopAudio();
                            },
                            icon: const Icon(Icons.stop_rounded),
                            label: const Text('إيقاف نهائي'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //------------
                /*
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          context.read<QuranMediaCubit>().playFullSurahAudio();
                          //context.read<QuranMediaCubit>().playFirstAyahAudio();
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('تشغيل'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<QuranMediaCubit>().pauseAudio();
                        },
                        icon: const Icon(Icons.pause_rounded),
                        label: const Text('إيقاف مؤقت'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<QuranMediaCubit>().stopAudio();
                        },
                        icon: const Icon(Icons.stop_rounded),
                        label: const Text('إيقاف'),
                      ),
                    ),
                  ],
                ),*/

                const SizedBox(height: 22),

                EditionSelector(
                  title: 'اختر المعنى أو الترجمة',
                  value: state.selectedMeaningEdition,
                  items: ApiConstants.meaningEditions,
                  onChanged: (edition) {
                    context.read<QuranMediaCubit>().loadMeaning(
                      surahNumber: surahNumber,
                      edition: edition,
                    );
                  },
                ),

                const SizedBox(height: 16),

                EditionSelector(
                  title: 'اختر التفسير',
                  value: state.selectedTafsirEdition,
                  items: ApiConstants.tafsirEditionsAr,
                  onChanged: (edition) {
                    context.read<QuranMediaCubit>().loadTafsir(
                      surahNumber: surahNumber,
                      edition: edition,
                    );
                  },
                ),

                const SizedBox(height: 24),

                if (state.status == QuranMediaStatus.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),

                if (state.status == QuranMediaStatus.failure)
                  Center(
                    child: Text(
                      state.errorMessage ?? 'حدث خطأ',
                      textAlign: TextAlign.center,
                    ),
                  ),

                if (state.status == QuranMediaStatus.success &&
                    state.ayahsText.isNotEmpty)
                  ...state.ayahsText.map(
                        (ayahText) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            ayahText,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 19,
                              height: 1.8,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
