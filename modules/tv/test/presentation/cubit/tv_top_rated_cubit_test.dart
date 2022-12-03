import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_top_rated_tv.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'tv_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TvTopRatedCubit cubit;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    cubit = TvTopRatedCubit(
      topRatedTv: mockGetTopRatedTv,
    );
  });

  group('Top Rated', () {
    test('should emit initial state', () {
      expect(cubit.state, TvTopRatedInitial());
    });
    blocTest<TvTopRatedCubit, TvTopRatedState>(
      'Should execute top rated list when function is called',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTv(),
      verify: (cubit) => mockGetTopRatedTv.execute(),
    );
    blocTest<TvTopRatedCubit, TvTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTv(),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedLoaded(testTvList),
      ],
      verify: (cubit) => mockGetTopRatedTv.execute(),
    );
    blocTest<TvTopRatedCubit, TvTopRatedState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTv(),
      expect: () => [
        TvTopRatedLoading(),
        const TvTopRatedError('Server Failure'),
      ],
      verify: (cubit) => mockGetTopRatedTv.execute(),
    );
  });
}
