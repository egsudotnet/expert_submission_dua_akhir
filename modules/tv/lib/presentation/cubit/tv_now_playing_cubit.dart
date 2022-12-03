import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecase/get_now_playing_tv.dart';

part 'tv_now_playing_state.dart';

class TvNowPlayingCubit extends Cubit<TvNowPlayingState> {
  final GetNowPlayingTv nowPlayingTv;

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
