
import 'package:flutter/material.dart';

class SurahPageNavigation extends StatelessWidget {
  final int currentSurah;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const SurahPageNavigation({
    super.key,
    required this.currentSurah,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(.2),
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: currentSurah > 1 ? onPrevious : null,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('السورة السابقة'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: currentSurah < 114 ? onNext : null,
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('السورة التالية'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}