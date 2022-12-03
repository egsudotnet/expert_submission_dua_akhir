import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';

import '../../dummy_data/dummy_tv_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late TvRepositoryImpl repository;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
      tvRemoteDataSource: mockTvRemoteDataSource,
    );
  });

  final tTv = TvModel(
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

  const tEpisode = EpisodeModel(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    seasonNumber: 0,
    stillPath: "stillPath",
    voteAverage: 0.0,
    voteCount: 0,
  );

  final tTvModelList = <TvModel>[tTv];
  final tEpisodeModelList = <EpisodeModel>[tEpisode];

  group('Now Playing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful ',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getNowPlayingTv();
      //assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(ServerException());
      //act
      final result = await repository.getNowPlayingTv();
      //assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getNowPlayingTv();
      //assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(ServerException());
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Episode Tv Series', () {
    const tId = 1;
    const tSeason = 1;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockTvRemoteDataSource.getTvEpisode(tId, tSeason))
          .thenAnswer((_) async => tEpisodeModelList);
      //act
      final result = await repository.getTvEpisode(tId, tSeason);
      //assert
      verify(mockTvRemoteDataSource.getTvEpisode(tId, tSeason));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testEpisodeList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTvEpisode(tId, tSeason))
          .thenThrow(ServerException());
      //act
      final result = await repository.getTvEpisode(tId, tSeason);
      //assert
      verify(mockTvRemoteDataSource.getTvEpisode(tId, tSeason));
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTvEpisode(tId, tSeason))
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvEpisode(tId, tSeason);
      //assert
      verify(mockTvRemoteDataSource.getTvEpisode(tId, tSeason));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
  group('Popular Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(ServerException());
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Recommended Tv Series', () {
    const tId = 1;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getRecommendationTv(tId))
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getTvRecommended(tId);
      //assert
      verify(mockTvRemoteDataSource.getRecommendationTv(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getRecommendationTv(tId))
          .thenThrow(ServerException());
      //act
      final result = await repository.getTvRecommended(tId);
      //assert
      verify(mockTvRemoteDataSource.getRecommendationTv(tId));
      expect(result, const Left(ServerFailure('')));
    });
    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getRecommendationTv(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvRecommended(tId);
      //assert
      verify(mockTvRemoteDataSource.getRecommendationTv(tId));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Search Tv Series', () {
    const tQuery = 'Squid Game';
    test(
        'should return search tv  list when call to data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.searchTv(tQuery);
      //assert
      verify(mockTvRemoteDataSource.searchTv(tQuery));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvList);
    });
    test('should return server exception when call remote is unsuccelful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(ServerException());
      //act
      final result = await repository.searchTv(tQuery);
      //assert
      verify(mockTvRemoteDataSource.searchTv(tQuery));
      expect(result, const Left(ServerFailure('')));
    });
    test('should return connection exception when call remote is unsuccesful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.searchTv(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.searchTv(tQuery);
      //assert
      verify(mockTvRemoteDataSource.searchTv(tQuery));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Detail Tv Series', () {
    const tId = 1;
    final tTvDetailModel = TvDetailModel(
      type: 'Tv',
      backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
      episodeRunTime: const [54],
      firstAirDate: '2021-09-17',
      genres: const [
        GenreModel(
          id: 10759,
          name: 'Action & Adventure',
        ),
      ],
      id: 1,
      languages: const ["en", "el"],
      lastAirDate: '2021-09-17',
      title: 'name',
      numberOfEpisode: 9,
      numberOfSeason: 1,
      originCountry: const ['KR'],
      originalLanguage: 'ko',
      originalName: '오징어 게임',
      overview: 'overview',
      popularity: 6379.492,
      posterPath: 'posterPath',
      seasons: const [
        SeasonModel(
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
      homePage: 'homePage',
      inProduction: false,
      lastEpisodeToAir: const EpisodeModel(
        airDate: 'airDate',
        episodeNumber: 0,
        id: 0,
        name: "name",
        overview: "overview",
        seasonNumber: 0,
        stillPath: "stillPath",
        voteAverage: 0.0,
        voteCount: 0,
      ),
    );

    test(
        'should return details tv  list when call to data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getDetailTv(tId))
          .thenAnswer((_) async => tTvDetailModel);
      //act
      final result = await repository.getTvDetail(tId);
      //assert
      verify(mockTvRemoteDataSource.getDetailTv(tId));
      expect(result, const Right(testTvDetail));
    });
    test('should return server exception when call remote is unsuccesful',
        () async {
      //assert
      when(mockTvRemoteDataSource.getDetailTv(tId))
          .thenThrow(ServerException());
      //act
      final result = await repository.getTvDetail(tId);
      //assert
      verify(mockTvRemoteDataSource.getDetailTv(tId));
      expect(result, const Left(ServerFailure('')));
    });

    test('should return connection exception when call remote is unsuccesful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getDetailTv(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvDetail(tId);
      //assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
