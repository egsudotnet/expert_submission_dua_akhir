import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ditonton/domain/entities/movie.dart'; 

part 'movie_top_rated_state.dart';

class MovieTopRatedCubit extends Cubit<MovieTopRatedState> {
  final GetTopRatedMovies topRatedMovie;

  MovieTopRatedCubit({required this.topRatedMovie})
      : super(MovieTopRatedInitial());

  void fetchTopRatedMovie() async {
    emit(MovieTopRatedLoading());

    final result = await topRatedMovie.execute();

    result.fold(
      (failure) async => emit(MovieTopRatedError(failure.message)),
      (data) async => emit(MovieTopRatedLoaded(data)),
    );
  }
}
