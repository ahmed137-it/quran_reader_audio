/*
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit() : super(SurahInitial());
}
*/
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/surah_repository.dart';
import 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  final SurahRepository repository;

  SurahCubit(this.repository) : super(const SurahState());

  Future<void> getSurahs() async {
    emit(state.copyWith(status: SurahStatus.loading));

    final result = await repository.getSurahs();

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: SurahStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SurahStatus.success,
        surahs: result.data ?? [],
      ),
    );
  }

  Future<void> getSurahByNumber(int surahNumber) async {
    emit(state.copyWith(status: SurahStatus.loading));

    final result = await repository.getSurahByNumber(surahNumber);

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: SurahStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SurahStatus.success,
        selectedSurah: result.data,
      ),
    );
  }
}