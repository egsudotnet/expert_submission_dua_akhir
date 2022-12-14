import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecase/get_popular_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });

  final tTv = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of popular tv  from the repository when execute function is called',
          () async {
        //arrage
        when(mockTvRepository.getPopularTv())
            .thenAnswer((_) async => Right(tTv));
        //act
        final result = await usecase.execute();
        //assert
        expect(result, Right(tTv));
      });
    });
  });
}
