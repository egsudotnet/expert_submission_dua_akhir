import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvsBloc bloc;
  late MockSearchTv searchTv;

  setUp(() {
    searchTv = MockSearchTv();
    bloc = SearchTvsBloc(
      searchTv: searchTv,
    );
  });

  test('should emit initial state', () {
    expect(bloc.state, SearchTvInitial());
  });

  final tTv = Tv(
    type: 'Tv',
    backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
    firstAirDate: '2021-09-17',
    id: 93405,
    ids: const [
      10759,
      9648,
      18,
    ],
    title: 'Squid game',
    originCountry: const ['KR'],
    originalLanguage: 'ko',
    originalName: '오징어 게임',
    overview: 'overview',
    popularity: 6379.492,
    posterPath: 'posterPath',
    voteAverage: 7.9,
    voteCount: 7704,
  );

  final tTvList = [tTv];
  const tQuery = 'Squid';
  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(searchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnChangeTvQuery(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsHasData(tTvList),
    ],
    verify: (bloc) => searchTv.execute(tQuery),
  );
  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Error] when data is failed',
    build: () {
      when(searchTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnChangeTvQuery(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      const SearchTvsError(''),
    ],
    verify: (bloc) => searchTv.execute(tQuery),
  );
}
