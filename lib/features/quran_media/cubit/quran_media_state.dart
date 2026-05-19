
import 'package:equatable/equatable.dart';

enum QuranMediaStatus {
  initial,
  loading,
  success,
  failure,
}

class QuranMediaState extends Equatable {
  final QuranMediaStatus status;
  final String selectedReciter;
  final String selectedMeaningEdition;
  final String selectedTafsirEdition;
  final Map<String, dynamic>? rawData;
  final List<String> audioUrls;
  final List<String> ayahsText;
  final String? errorMessage;

  const QuranMediaState({
    this.status = QuranMediaStatus.initial,
    this.selectedReciter = 'ar.minshawi',
    this.selectedMeaningEdition = 'ar.muyassar',
    this.selectedTafsirEdition = 'ar.muyassar',
    this.rawData,
    this.audioUrls = const [],
    this.ayahsText = const [],
    this.errorMessage,
  });

  QuranMediaState copyWith({
    QuranMediaStatus? status,
    String? selectedReciter,
    String? selectedMeaningEdition,
    String? selectedTafsirEdition,
    Map<String, dynamic>? rawData,
    List<String>? audioUrls,
    List<String>? ayahsText,
    String? errorMessage,
  }) {
    return QuranMediaState(
      status: status ?? this.status,
      selectedReciter: selectedReciter ?? this.selectedReciter,
      selectedMeaningEdition:
      selectedMeaningEdition ?? this.selectedMeaningEdition,
      selectedTafsirEdition:
      selectedTafsirEdition ?? this.selectedTafsirEdition,
      rawData: rawData ?? this.rawData,
      audioUrls: audioUrls ?? this.audioUrls,
      ayahsText: ayahsText ?? this.ayahsText,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedReciter,
    selectedMeaningEdition,
    selectedTafsirEdition,
    rawData,
    audioUrls,
    ayahsText,
    errorMessage,
  ];
}
/*
import 'package:equatable/equatable.dart';

enum QuranMediaStatus {
  initial,
  loading,
  success,
  failure,
}

class QuranMediaState extends Equatable {
  final QuranMediaStatus status;
  final String selectedReciter;
  final String selectedMeaningEdition;
  final String selectedTafsirEdition;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  const QuranMediaState({
    this.status = QuranMediaStatus.initial,
    this.selectedReciter = 'ar.minshawi',
    this.selectedMeaningEdition = 'ar.muyassar',
    this.selectedTafsirEdition = 'ar.muyassar',
    this.data,
    this.errorMessage,
  });

  QuranMediaState copyWith({
    QuranMediaStatus? status,
    String? selectedReciter,
    String? selectedMeaningEdition,
    String? selectedTafsirEdition,
    Map<String, dynamic>? data,
    String? errorMessage,
  }) {
    return QuranMediaState(
      status: status ?? this.status,
      selectedReciter: selectedReciter ?? this.selectedReciter,
      selectedMeaningEdition: selectedMeaningEdition ?? this.selectedMeaningEdition,
      selectedTafsirEdition: selectedTafsirEdition ?? this.selectedTafsirEdition,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedReciter,
    selectedMeaningEdition,
    selectedTafsirEdition,
    data,
    errorMessage,
  ];
}
*/
