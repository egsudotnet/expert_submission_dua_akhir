import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_now_playing_tv.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'tv_now_playing_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
])
void main() {
  late TvNowPlayingCubit cubit;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    cubit = TvNowPlayingCubit(
      nowPlayingTv: mockGetNowPlayingTv,
    );
  });

  group('Now playing', () {
    test('should emit initial state', () {
      expect(cubit.state, TvNowPlayingInitial());
    });
    blocTest<TvNowPlayingCubit, TvNowPlayingState>(
      'Should execute now playing list when function is called',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTv(),
      verify: (cubit) => mockGetNowPlayingTv.execute(),
    );
    blocTest<TvNowPlayingCubit, TvNowPlayingState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvList));

        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTv(),
      expect: () => [
        TvNowPlayingLoading(),
        TvNowPlayingLoaded(testTvList),
      ],
      verify: (cubit) => mockGetNowPlayingTv.execute(),
    );
    blocTest<TvNowPlayingCubit, TvNowPlayingState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTv(),
      expect: () => [
        TvNowPlayingLoading(),
        const TvNowPlayingError('Server Failure'),
      ],
      verify: (cubit) => mockGetNowPlayingTv.execute(),
    );
  });
}
