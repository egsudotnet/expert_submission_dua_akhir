part of 'tv_now_playing_cubit.dart';

@immutable
abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();

  @override
  List<Object?> get props => [];
}

class TvNowPlayingInitial extends TvNowPlayingState {}

class TvNowPlayingLoading extends TvNowPlayingState {}

class TvNowPlayingLoaded extends TvNowPlayingState {
  final List<Tv> nowPlayingTv;

  const TvNowPlayingLoaded(this.nowPlayingTv);

  @override
  List<Object?> get props => [nowPlayingTv];
}

class TvNowPlayingError extends TvNowPlayingState {
  final String message;

  const TvNowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}
