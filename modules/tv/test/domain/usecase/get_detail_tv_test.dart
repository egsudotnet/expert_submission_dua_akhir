import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecase/get_detail_tv.dart';

import '../../dummy_data/dummy_tv_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetDetailTv usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetDetailTv(mockTvRepository);
  });

  const tId = 1;
  group('Get Detail Tv Series', () {
    group('execute', () {
      test(
          'should return tv  details from repository when function is called',
          () async {
        //arrange
        when(mockTvRepository.getTvDetail(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        //act
        final result = await usecase.execute(tId);
        //assert
        expect(result, const Right(testTvDetail));
      });
    });
  });
}
