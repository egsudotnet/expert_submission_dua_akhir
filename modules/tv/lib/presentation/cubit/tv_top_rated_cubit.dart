import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecase/get_top_rated_tv.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedCubit extends Cubit<TvTopRatedState> {
  final GetTopRatedTv topRatedTv;

  TvTopRatedCubit({required this.topRatedTv})
      : super(TvTopRatedInitial());

  void fetchTopRatedTv() async {
    emit(TvTopRatedLoading());

    final result = await topRatedTv.execute();

    result.fold(
      (failure) async => emit(TvTopRatedError(failure.message)),
      (data) async => emit(TvTopRatedLoaded(data)),
    );
  }
}
