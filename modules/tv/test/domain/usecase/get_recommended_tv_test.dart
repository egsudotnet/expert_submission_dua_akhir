import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecase/get_recommendation_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetRecommendationTv usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetRecommendationTv(mockTvRepository);
  });

  const tId = 1;
  final tTv = <Tv>[];

  test('should return recommended tv  list when function is called',
      () async {
    //arrange
    when(mockTvRepository.getTvRecommended(tId))
        .thenAnswer((_) async => Right(tTv));
    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, Right(tTv));
  });
}
