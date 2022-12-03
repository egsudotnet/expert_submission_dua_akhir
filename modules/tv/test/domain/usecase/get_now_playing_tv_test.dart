import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecase/get_now_playing_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetNowPlayingTv(mockTvRepository);
  });

  final tTv = <Tv>[];
  group('GetNowPlayingTv Test', () {
    group('execute', () {
      test(
          'should get list of now playing tv  list when function is called',
          () async {
        //arrange
        when(mockTvRepository.getNowPlayingTv())
            .thenAnswer((_) async => Right(tTv));
        //act
        final result = await usecase.execute();
        //assert
        expect(result, Right(tTv));
      });
    });
  });
}
