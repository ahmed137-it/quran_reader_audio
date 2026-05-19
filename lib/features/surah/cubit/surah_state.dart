/*
part of 'surah_cubit.dart';

@immutable
sealed class SurahState {}

final class SurahInitial extends SurahState {}
*/

import 'package:equatable/equatable.dart';
import '../models/surah_model.dart';

enum SurahStatus {
  initial,
  loading,
  success,
  failure,
}

class SurahState extends Equatable {
  final SurahStatus status;
  final List<SurahModel> surahs;
  final SurahModel? selectedSurah;
  final String? errorMessage;

  const SurahState({
    this.status = SurahStatus.initial,
    this.surahs = const [],
    this.selectedSurah,
    this.errorMessage,
  });

  SurahState copyWith({
    SurahStatus? status,
    List<SurahModel>? surahs,
    SurahModel? selectedSurah,
    String? errorMessage,
  }) {
    return SurahState(
      status: status ?? this.status,
      surahs: surahs ?? this.surahs,
      selectedSurah: selectedSurah ?? this.selectedSurah,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    surahs,
    selectedSurah,
    errorMessage,
  ];
}