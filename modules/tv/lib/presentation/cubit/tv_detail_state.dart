part of 'tv_detail_cubit.dart';

@immutable
abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object?> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tvDetail;
  final List<Tv> recommendationTv;

  const TvDetailLoaded(
    this.tvDetail,
    this.recommendationTv,
  );

  @override
  List<Object?> get props => [
        tvDetail,
        recommendationTv,
      ];
}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvRecommendationLoading extends TvDetailState {}

class TvRecommendationError extends TvDetailState {
  final String message;

  const TvRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
