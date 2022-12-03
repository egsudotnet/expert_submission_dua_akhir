import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../tv/test/dummy_data/dummy_tv_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlist(
      mockMovieRepository,
    );
  });

  final tMovie = Movie(
    type: 'Movie',
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 1,
    originalTitle: 'Spider-Man',
    overview: 'overview',
    popularity: 60.441,
    posterPath: 'posterPath',
    releaseDate: '2002-05-01',
    title: 'title',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  test('should save movie to the wathlist', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(tMovie))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tMovie);
    // assert
    verify(mockMovieRepository.saveWatchlist(tMovie));
    expect(result, const Right('Added to Watchlist'));
  });

  test('should save tv  to the wathlist', () async {
    final tTv = Movie.watchlist(
      id: testTv.id!,
      overview: testTv.overview,
      posterPath: testTv.posterPath,
      title: testTv.title,
      type: testTv.type,
    );
    // arrange
    when(mockMovieRepository.saveWatchlist(tTv))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvToMovie);
    // assert
    verify(mockMovieRepository.saveWatchlist(tTv));
    expect(result, const Right('Added to Watchlist'));
  });
}
