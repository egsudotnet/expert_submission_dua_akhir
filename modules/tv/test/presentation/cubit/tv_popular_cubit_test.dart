import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_popular_tv.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'tv_popular_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late TvPopularCubit cubit;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    cubit = TvPopularCubit(
      popularTv: mockGetPopularTv,
    );
  });

  group('Popular', () {
    test('should emit initial state', () {
      expect(cubit.state, TvPopularInitial());
    });
    blocTest<TvPopularCubit, TvPopularState>(
      'Should execute popular list when function is called',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTv(),
      verify: (cubit) => mockGetPopularTv.execute(),
    );
    blocTest<TvPopularCubit, TvPopularState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTv(),
      expect: () => [
        TvPopularLoading(),
        TvPopularLoaded(testTvList),
      ],
      verify: (cubit) => mockGetPopularTv.execute(),
    );
    blocTest<TvPopularCubit, TvPopularState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTv(),
      expect: () => [
        TvPopularLoading(),
        const TvPopularError('Server Failure'),
      ],
      verify: (cubit) => mockGetPopularTv.execute(),
    );
  });
}
