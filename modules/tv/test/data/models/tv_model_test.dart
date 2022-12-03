import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';

void main() {
  final tTvModel = TvModel(
    type: 'Tv',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    ids: const [1, 2, 3],
    title: 'title',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 0,
    posterPath: 'posterPath',
    voteAverage: 0.0,
    voteCount: 0,
  );

  final tTv = Tv(
    type: 'Tv',
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    id: 1,
    ids: const [1, 2, 3],
    title: 'title',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 0,
    posterPath: 'posterPath',
    voteAverage: 0.0,
    voteCount: 0,
  );

  final tTvTable = TvTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    posterPath: 'posterPath',
    type: 'Tv',
  );

  final tTvJson = {
    'type': 'Tv',
    'backdrop_path': 'backdropPath',
    'first_air_date': 'firstAirDate',
    'id': 1,
    'genre_ids': const [1, 2, 3],
    'title': 'title',
    'origin_country': const ['originCountry'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 0,
    'poster_path': 'posterPath',
    'vote_average': 0.0,
    'vote_count': 0,
  };

  final tTvMap = {
    'type': 'Tv',
    'backdrop_path': 'backdropPath',
    'first_air_date': 'firstAirDate',
    'id': 1,
    'genre_ids': const [1, 2, 3],
    'name': 'title',
    'origin_country': const ['originCountry'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 0,
    'poster_path': 'posterPath',
    'vote_average': 0.0,
    'vote_count': 0,
  };

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = tTvMap;
    // act
    final result = TvModel.fromJson(jsonMap);
    // assert
    expect(result, tTvModel);
  });

  test('should return a JSON map containing proper data', () async {
    // act
    final result = tTvModel.toJson();
    // assert
    final expectedJsonMap = tTvJson;
    expect(result, expectedJsonMap);
  });

  test('should return a TvTable JSON map containing proper data',
      () async {
    // act
    final result = tTvTable.toJson();
    // assert
    final expectedJsonMap = {
      'id': 1,
      'title': 'title',
      'poster_path': 'posterPath',
      'overview': 'overview',
      'type': 'Tv',
    };
    expect(result, expectedJsonMap);
  });
}
