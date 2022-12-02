import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ditonton/domain/entities/tv.dart'; 

part 'tv_top_rated_state.dart';

class TvTopRatedCubit extends Cubit<TvTopRatedState> {
  final GetTopRatedTvs topRatedTv;

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
