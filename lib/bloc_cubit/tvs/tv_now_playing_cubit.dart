import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart'; 

part 'tv_now_playing_state.dart';

class TvNowPlayingCubit extends Cubit<TvNowPlayingState> {
  final GetNowPlayingTvs nowPlayingTv;

  TvNowPlayingCubit({
    required this.nowPlayingTv,
  }) : super(TvNowPlayingInitial());

  void fetchNowPlayingTv() async {
    emit(TvNowPlayingLoading());

    final result = await nowPlayingTv.execute();

    result.fold(
      (failure) async {
        emit(TvNowPlayingError(failure.message));
      },
      (data) async {
        emit(TvNowPlayingLoaded(data));
      },
    );
  }
}
