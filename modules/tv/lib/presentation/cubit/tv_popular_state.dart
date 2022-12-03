part of 'tv_popular_cubit.dart';

@immutable
abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object?> get props => [];
}

class TvPopularInitial extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularLoaded extends TvPopularState {
  final List<Tv> popularTv;

  const TvPopularLoaded(this.popularTv);

  @override
  List<Object?> get props => [popularTv];
}

class TvPopularError extends TvPopularState {
  final String message;

  const TvPopularError(this.message);

  @override
  List<Object?> get props => [message];
}
