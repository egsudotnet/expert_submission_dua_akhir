import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecase/get_popular_tv.dart';

part 'tv_popular_state.dart';

class TvPopularCubit extends Cubit<TvPopularState> {
  final GetPopularTv popularTv;

  TvPopularCubit({required this.popularTv})
      : super(TvPopularInitial());

  void fetchPopularTv() async {
    emit(TvPopularLoading());

    final result = await popularTv.execute();

    result.fold(
      (failure) async => emit(TvPopularError(failure.message)),
      (data) async => emit(TvPopularLoaded(data)),
    );
  }
}
