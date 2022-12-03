import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_tv_episode.dart';

import '../../dummy_data/dummy_tv_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvEpisode usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvEpisode(mockTvRepository);
  });

  const tId = 1;
  const tSeason = 1;
  group('Get Episode Tv Series', () {
    group('execute', () {
      test(
          'should return tv  episode from repository when function is called',
          () async {
        //arrange
        when(mockTvRepository.getTvEpisode(tId, tSeason))
            .thenAnswer((_) async => Right(testEpisodeList));
        //act
        final result = await usecase.execute(tId, tSeason);
        //assert
        expect(result, Right(testEpisodeList));
      });
    });
  });
}
