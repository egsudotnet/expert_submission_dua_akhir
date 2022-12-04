import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasource/tv_remote_data_source.dart';
import 'package:tv/data/models/epidose_response.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    mockIOClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(client: mockIOClient);
  });

  const tId = 93405;

  group('Get Now Playing Tv Series List', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_now_playing.json')))
        .tvList;

    test(
        'should return Now Playing Tv Series List when response status code is 200',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/on_the_air?api_key=$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_now_playing.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      //act
      final result = await dataSource.getNowPlayingTv();
      //assert
      expect(result, tTvList);
    });

    test('should throw a Server Exception when response code is 404 or other',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/on_the_air?api_key=$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getNowPlayingTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Tv Series List', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_popular.json')))
        .tvList;
    test(
        'should return Model of Tv Series Popular List when response status code is 200',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/popular?api_key=$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_popular.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      //act
      final result = await dataSource.getPopularTv();
      //assert
      expect(result, tTvList);
    });

    test('should throw a Server Exception when response code is 404 or other',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/popular?api_key=$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getPopularTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Recommended Tv Series List', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendation.json')))
        .tvList;
    test('should return Recommended Tv Series List when response code is 200',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/$tId/recommendations?api_key=$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_recommendation.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      //act
      final result = await dataSource.getRecommendationTv(tId);
      //assert
      expect(result, tTvList);
    });

    test('should return Server Exception when response code is 404 or other',
        () {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/$tId/recommendations?api_key=$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getRecommendationTv(tId);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Detail Tv Series', () {
    final tTvDetail = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return Detail Tv Series when response body is 200', () async {
      //arrange
      when(mockIOClient.get(
              Uri.parse('$baseUrl/tv/$tId?api_key=$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      //act
      final result = await dataSource.getDetailTv(tId);
      //assert
      expect(result, tTvDetail);
    });

    test('should return Server Exception when response body is 404 or other',
        () {
      //arrange
      when(mockIOClient.get(
              Uri.parse('$baseUrl/tv/$tId?api_key=$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.getDetailTv(tId);
      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('Search Tv Series List', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/search_tv.json')))
        .tvList;

    const tQuery = 'Squid Game';

    test('should return Searc Tv Series List when response code is 200',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/search/tv?api_key=$apiKey&query=$tQuery')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/search_tv.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      //act
      final result = await dataSource.searchTv(tQuery);
      //assert
      expect(result, tTvList);
    });

    test('should return Server Exception when response body is 404 or other',
        () {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/search/tv?api_key=$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.searchTv(tQuery);
      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Tv Series', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;
    test('should return Searc Tv Series List when response code is 200',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/top_rated?api_key=$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_top_rated.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      //act
      final result = await dataSource.getTopRatedTv();
      //assert
      expect(result, tTvList);
    });
    test('should throw a Server Exception when response code is 404 or other',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/top_rated?api_key=$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTopRatedTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Series Episode', () {
    final tEpisodeList = EpisodeResponse.fromJson(
            json.decode(readJson('dummy_data/tv_episode.json')))
        .episodeList;
    const tSeason = 1;
    test('should return Searc Tv Series List when response code is 200',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/$tId/season/$tSeason?api_key=$apiKey')))
          .thenAnswer(
        (_) async =>
            http.Response(readJson('dummy_data/tv_episode.json'), 200),
      );
      //act
      final result = await dataSource.getTvEpisode(tId, tSeason);
      //assert
      expect(result, tEpisodeList);
    });
    test('should throw a Server Exception when response code is 404 or other',
        () async {
      //arrange
      when(mockIOClient.get(Uri.parse(
              '$baseUrl/tv/$tId/season/$tSeason?api_key=$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final call = dataSource.getTvEpisode(tId, tSeason);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
