import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/presentation/pages/home_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_movie_objects.dart';
import '../../dummy_data/dummy_tv_object.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([
  MovieNowPlayingCubit,
  MoviePopularCubit,
  MovieTopRatedCubit,
  TvNowPlayingCubit,
  TvPopularCubit,
  TvTopRatedCubit,
])
void main() {
  late MockMovieNowPlayingCubit mockMovieNowPlayingCubit;
  late MockMoviePopularCubit mockMoviePopularCubit;
  late MockMovieTopRatedCubit mockMovieTopRatedCubit;

  late MockTvNowPlayingCubit mockTvNowPlayingCubit;
  late MockTvPopularCubit mockTvPopularCubit;
  late MockTvTopRatedCubit mockTvTopRatedCubit;

  setUp(() {
    mockMovieNowPlayingCubit = MockMovieNowPlayingCubit();
    mockMoviePopularCubit = MockMoviePopularCubit();
    mockMovieTopRatedCubit = MockMovieTopRatedCubit();

    mockTvNowPlayingCubit = MockTvNowPlayingCubit();
    mockTvPopularCubit = MockTvPopularCubit();
    mockTvTopRatedCubit = MockTvTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieNowPlayingCubit>.value(
      value: mockMovieNowPlayingCubit,
      child: BlocProvider<MoviePopularCubit>.value(
        value: mockMoviePopularCubit,
        child: BlocProvider<MovieTopRatedCubit>.value(
          value: mockMovieTopRatedCubit,
          child: BlocProvider<TvNowPlayingCubit>.value(
            value: mockTvNowPlayingCubit,
            child: BlocProvider<TvPopularCubit>.value(
              value: mockTvPopularCubit,
              child: BlocProvider<TvTopRatedCubit>.value(
                value: mockTvTopRatedCubit,
                child: MaterialApp(
                  home: body,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
   
  testWidgets('Page should display ResultMovie and center progress bar when loading',
      (WidgetTester tester) async {
    when(mockMovieNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(MovieNowPlayingLoading()));
    when(mockMovieNowPlayingCubit.state).thenReturn(MovieNowPlayingLoading());
    when(mockMoviePopularCubit.stream)
        .thenAnswer((_) => Stream.value(MoviePopularLoading()));
    when(mockMoviePopularCubit.state).thenReturn(MoviePopularLoading());
    when(mockMovieTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedLoading()));
    when(mockMovieTopRatedCubit.state).thenReturn(MovieTopRatedLoading());

    when(mockTvNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(TvNowPlayingLoading()));
    when(mockTvNowPlayingCubit.state).thenReturn(TvNowPlayingLoading());
    when(mockTvPopularCubit.stream)
        .thenAnswer((_) => Stream.value(TvPopularLoading()));
    when(mockTvPopularCubit.state).thenReturn(TvPopularLoading());
    when(mockTvTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(TvTopRatedLoading()));
    when(mockTvTopRatedCubit.state).thenReturn(TvTopRatedLoading());

    final resultMovieFinder = find.byType(ResultMovie);
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byKey(const Key('center_progressbar'));

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    expect(resultMovieFinder, findsNWidgets(1));
    expect(centerFinder, findsNWidgets(3));
    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockMovieNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(MovieNowPlayingLoaded(testMovieList)));
    when(mockMovieNowPlayingCubit.state)
        .thenReturn(MovieNowPlayingLoaded(testMovieList));
    when(mockMoviePopularCubit.stream)
        .thenAnswer((_) => Stream.value(MoviePopularLoaded(testMovieList)));
    when(mockMoviePopularCubit.state)
        .thenReturn(MoviePopularLoaded(testMovieList));
    when(mockMovieTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(MovieTopRatedLoaded(testMovieList)));
    when(mockMovieTopRatedCubit.state)
        .thenReturn(MovieTopRatedLoaded(testMovieList));
        
    when(mockTvNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(TvNowPlayingLoaded(testTvList)));
    when(mockTvNowPlayingCubit.state)
        .thenReturn(TvNowPlayingLoaded(testTvList));
    when(mockTvPopularCubit.stream)
        .thenAnswer((_) => Stream.value(TvPopularLoaded(testTvList)));
    when(mockTvPopularCubit.state)
        .thenReturn(TvPopularLoaded(testTvList));
    when(mockTvTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(TvTopRatedLoaded(testTvList)));
    when(mockTvTopRatedCubit.state)
        .thenReturn(TvTopRatedLoaded(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockMovieNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieNowPlayingError('Failed')));
    when(mockMovieNowPlayingCubit.state)
        .thenReturn(const MovieNowPlayingError('Failed'));
    when(mockMoviePopularCubit.stream)
        .thenAnswer((_) => Stream.value(const MoviePopularError('Failed')));
    when(mockMoviePopularCubit.state)
        .thenReturn(const MoviePopularError('Failed'));
    when(mockMovieTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieTopRatedError('Failed')));
    when(mockMovieTopRatedCubit.state)
        .thenReturn(const MovieTopRatedError('Failed'));
        
    when(mockTvNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(const TvNowPlayingError('Failed')));
    when(mockTvNowPlayingCubit.state)
        .thenReturn(const TvNowPlayingError('Failed'));
    when(mockTvPopularCubit.stream)
        .thenAnswer((_) => Stream.value(const TvPopularError('Failed')));
    when(mockTvPopularCubit.state)
        .thenReturn(const TvPopularError('Failed'));
    when(mockTvTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(const TvTopRatedError('Failed')));
    when(mockTvTopRatedCubit.state)
        .thenReturn(const TvTopRatedError('Failed'));

    final textFinder = find.text('Failed');

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    expect(textFinder, findsNWidgets(3));
  });
}
