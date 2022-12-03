import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';  

import 'package:movie/movie.dart';  
import 'package:search/search.dart';  
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

void init(HttpClient httpClient) {
  // cubit
  locator.registerFactory(
    () => MovieNowPlayingCubit(
      nowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularCubit(
      popularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedCubit(
      topRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMoviesBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailCubit(
      detailTv: locator(),
      recommendationTv: locator(),
    ),
  );
  locator.registerFactory(
    () => EpisodeCubit(
      tvEpisode: locator(),
    ),
  );
  locator.registerFactory(
    () => TvNowPlayingCubit(
      nowPlayingTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedCubit(
      topRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularCubit(
      popularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvsBloc(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistCubit(
      watchlist: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetRecommendationTv(locator()));
  locator.registerLazySingleton(() => GetTvEpisode(locator()));
  locator.registerLazySingleton(() => GetDetailTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      tvRemoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => IOClient(httpClient));
}
