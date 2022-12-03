import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_detail_tv.dart';
import 'package:tv/domain/usecase/get_recommendation_tv.dart';
import 'package:tv/presentation/cubit/tv_detail_cubit.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetDetailTv,
  GetRecommendationTv,
])
void main() {
  late TvDetailCubit cubit;
  late MockGetDetailTv mockGetDetailTv;
  late MockGetRecommendationTv mockGetRecommendationTv;

  setUp(() {
    mockGetRecommendationTv = MockGetRecommendationTv();
    mockGetDetailTv = MockGetDetailTv();
    cubit = TvDetailCubit(
      detailTv: mockGetDetailTv,
      recommendationTv: mockGetRecommendationTv,
    );
  });

  group('Get Tv Series Detail and Recommendation Tv Series', () {
    test('initial state should be empty', () {
      expect(cubit.state, TvDetailInitial());
    });

    blocTest<TvDetailCubit, TvDetailState>(
      'should execute tv detail when function called',
      build: () {
        when(mockGetDetailTv.execute(testTv.id))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetRecommendationTv.execute(testTv.id))
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTv.id!),
      verify: (cubit) => mockGetDetailTv.execute(testTv.id),
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'should execute  recommendation when function called',
      build: () {
        when(mockGetDetailTv.execute(testTv.id))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetRecommendationTv.execute(testTv.id))
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTv.id!),
      verify: (cubit) => mockGetDetailTv.execute(testTv.id),
    );

    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetDetailTv.execute(testTv.id))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetRecommendationTv.execute(testTv.id))
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTv.id!),
      expect: () => [
        TvDetailLoading(),
        TvRecommendationLoading(),
        TvDetailLoaded(
          testTvDetail,
          testTvList,
        ),
      ],
      verify: (cubit) {
        mockGetDetailTv.execute(testTv.id);
        mockGetRecommendationTv.execute(testTv.id);
      },
    );
    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetDetailTv.execute(testTv.id)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetRecommendationTv.execute(testTv.id)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTv.id!),
      expect: () => [
        TvDetailLoading(),
        const TvDetailError('Server Failure'),
      ],
      verify: (cubit) {
        mockGetDetailTv.execute(testTv.id);
        mockGetRecommendationTv.execute(testTv.id);
      },
    );
    blocTest<TvDetailCubit, TvDetailState>(
      'Should emit [Loading, Error] when recommendation is gotten successfully',
      build: () {
        when(mockGetDetailTv.execute(testTv.id))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetRecommendationTv.execute(testTv.id)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTv.id!),
      expect: () => [
        TvDetailLoading(),
        TvRecommendationLoading(),
        const TvRecommendationError('Server Failure'),
      ],
      verify: (cubit) {
        mockGetDetailTv.execute(testTv.id);
        mockGetRecommendationTv.execute(testTv.id);
      },
    );
  });
}
