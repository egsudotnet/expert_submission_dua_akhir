import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTv = Tv(
  type: 'Tv',
  backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
  firstAirDate: '2021-09-17',
  id: 93405,
  ids: const [
    10759,
    9648,
    18,
  ],
  title: 'name',
  originCountry: const ['KR'],
  originalLanguage: 'ko',
  originalName: '오징어 게임',
  overview: 'overview',
  popularity: 6379.492,
  posterPath: 'posterPath',
  voteAverage: 7.9,
  voteCount: 7704,
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  type: 'Tv',
  backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
  episodeRunTime: [54],
  firstAirDate: '2021-09-17',
  genres: [
    Genre(
      id: 10759,
      name: 'Action & Adventure',
    ),
  ],
  id: 1,
  languages: ["en", "el"],
  lastAirDate: '2021-09-17',
  title: 'name',
  numberOfEpisode: 9,
  numberOfSeason: 1,
  originCountry: ['KR'],
  originalLanguage: 'ko',
  originalName: '오징어 게임',
  overview: 'overview',
  popularity: 6379.492,
  posterPath: 'posterPath',
  seasons: [
    Season(
      airDate: '2021-09-17',
      episodeCount: 9,
      id: 131977,
      name: 'Season 1',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  status: 'Ended',
  tagline: '45.6 billion won is child\'s play.',
  voteAverage: 7.9,
  voteCount: 7705,
);

final testTvToMovie = Movie.watchlist(
  id: testTv.id!,
  overview: testTv.overview,
  posterPath: testTv.posterPath,
  title: testTv.title,
  type: 'Tv',
);

final testTvWatchlist = Tv.watchlist(
  id: 1,
  title: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'Tv',
);

final testtvTable = TvTable(
  id: 1,
  title: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'Tv',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'poster_path': 'posterPath',
  'title': 'name',
  'type': 'Tv',
};

const testEpisode = Episode(
  airDate: 'airDate',
  episodeNumber: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  seasonNumber: 0,
  stillPath: 'stillPath',
  voteAverage: 0.0,
  voteCount: 0,
);

final testEpisodeList = [testEpisode];
