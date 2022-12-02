part of 'tv_top_rated_cubit.dart';

@immutable
abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();

  @override
  List<Object?> get props => [];
}

class TvTopRatedInitial extends TvTopRatedState {}

class TvTopRatedLoading extends TvTopRatedState {}

class TvTopRatedLoaded extends TvTopRatedState {
  final List<Tv> topRatedTv;

  const TvTopRatedLoaded(this.topRatedTv);

  @override
  List<Object?> get props => [topRatedTv];
}

class TvTopRatedError extends TvTopRatedState {
  final String message;

  const TvTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
