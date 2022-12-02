import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart'; 

part 'movie_now_playing_state.dart';

class MovieNowPlayingCubit extends Cubit<MovieNowPlayingState> {
  final GetNowPlayingMovies nowPlayingMovie;

  MovieNowPlayingCubit({
    required this.nowPlayingMovie,
  }) : super(MovieNowPlayingInitial());

  void fetchNowPlayingMovie() async {
    emit(MovieNowPlayingLoading());

    final result = await nowPlayingMovie.execute();

    result.fold(
      (failure) async {
        emit(MovieNowPlayingError(failure.message));
      },
      (data) async {
        emit(MovieNowPlayingLoaded(data));
      },
    );
  }
}
