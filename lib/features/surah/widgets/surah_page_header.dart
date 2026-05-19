
import 'package:flutter/material.dart';
import '../models/surah_model.dart';

class SurahPageHeader extends StatelessWidget {
  final SurahModel surah;
  final String revelationPlace;
  final VoidCallback onMediaPressed;

  const SurahPageHeader({
    super.key,
    required this.surah,
    required this.revelationPlace,
    required this.onMediaPressed,
  });

  @override
  Widget build(BuildContext context) {
    final showBasmala = surah.number != 1 && surah.number != 9;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBasmala)
            const Text(
              'بِسْمِ ٱللّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                height: 1.6,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

          if (showBasmala) const SizedBox(height: 10),

          SizedBox(
            height: 38,
            child: OutlinedButton.icon(
              onPressed: onMediaPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
              ),
              icon: const Icon(
                Icons.headphones_rounded,
                size: 18,
              ),
              label: const Text(
                'الأصوات والمعاني والتفاسير',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

import '../../../../core/utils/arabic_numbers.dart';
import '../models/surah_model.dart';

class SurahPageHeader extends StatelessWidget {
  final SurahModel surah;
  final String revelationPlace;
  final VoidCallback onMediaPressed;

  const SurahPageHeader({
    super.key,
    required this.surah,
    required this.revelationPlace,
    required this.onMediaPressed,
  });

  @override
  Widget build(BuildContext context) {
    final showBasmala = surah.number != 1 && surah.number != 9;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            surah.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$revelationPlace • ${ArabicNumbers.convert(surah.numberOfAyahs)} آية',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showBasmala) ...[
            const SizedBox(height: 10),
            const Text(
              'بِسْمِ ٱللّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 23,
                height: 1.7,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            height: 38,
            child: OutlinedButton.icon(
              onPressed: onMediaPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(
                Icons.headphones_rounded,
                size: 19,
              ),
              label: const Text(
                'الأصوات والمعاني والتفاسير',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/utils/arabic_numbers.dart';
import '../models/surah_model.dart';

class SurahPageHeader extends StatelessWidget {
  final SurahModel surah;

  const SurahPageHeader({
    super.key,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    final isMeccan = surah.revelationType == 'Meccan' ||
        surah.revelationType == 'مكية';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            surah.name,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${isMeccan ? 'مكية' : 'مدنية'} • ${ArabicNumbers.convert(surah.numberOfAyahs)} آية',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          if (surah.number != 1 && surah.number != 9) ...[
            const SizedBox(height: 18),
            const Text(
              'بِسْمِ ٱللّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'Amiri',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
*/