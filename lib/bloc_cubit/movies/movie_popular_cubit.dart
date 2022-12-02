import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ditonton/domain/entities/movie.dart';

part 'movie_popular_state.dart';

class MoviePopularCubit extends Cubit<MoviePopularState> {
  final GetPopularMovies popularMovie;

  MoviePopularCubit({required this.popularMovie})
      : super(MoviePopularInitial());

  void fetchPopularMovie() async {
    emit(MoviePopularLoading());

    final result = await popularMovie.execute();

    result.fold(
      (failure) async => emit(MoviePopularError(failure.message)),
      (data) async => emit(MoviePopularLoaded(data)),
    );
  }
}
