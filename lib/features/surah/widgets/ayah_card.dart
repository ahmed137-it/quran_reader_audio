
/*
import 'package:flutter/material.dart';
import '../../../../core/utils/arabic_numbers.dart';
import '../models/ayah_model.dart';

class AyahCard extends StatelessWidget {
  final AyahModel ayah;

  const AyahCard({
    super.key,
    required this.ayah,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: RichText(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          text: TextSpan(
            style: TextStyle(
              fontSize: 26,
              height: 2.0,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Amiri',
            ),
            children: [
              TextSpan(
                text: ayah.text,
              ),
              TextSpan(
                text: '  ۝ ${ArabicNumbers.convert(ayah.numberInSurah)}',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.0,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import '../../../../core/utils/arabic_numbers.dart';
import '../models/ayah_model.dart';

class AyahCard extends StatelessWidget {
  final AyahModel ayah;

  const AyahCard({
    super.key,
    required this.ayah,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: RichText(
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          text: TextSpan(
            style: TextStyle(
              fontSize: 26,
              height: 1.8,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Amiri',
            ),
            children: [
              TextSpan(text: ayah.text),
              TextSpan(
                text: ' ﴿${ArabicNumbers.convert(ayah.numberInSurah)}﴾',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
