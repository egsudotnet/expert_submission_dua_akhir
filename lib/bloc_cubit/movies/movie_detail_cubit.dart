import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail detailMovie;
  final GetMovieRecommendations recommendationMovie;

  MovieDetailCubit({
    required this.detailMovie,
    required this.recommendationMovie,
  }) : super(MovieDetailInitial());

  void fetchDetailMovie(int id) async {
    emit(MovieDetailLoading());

    final result = await detailMovie.execute(id);
    final recommendation = await recommendationMovie.execute(id);

    result.fold(
      (failure) async {
        emit(MovieDetailError(failure.message));
      },
      (detail) async {
        emit(MovieRecommendationLoading());

        recommendation.fold(
          (failure) async {
            emit(MovieRecommendationError(failure.message));
          },
          (recomendation) async {
            emit(MovieDetailLoaded(detail, recomendation));
          },
        );
      },
    );
  }
}
