import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home/presentation/pages/home_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart'; 

import '../../../../tv/test/dummy_data/dummy_tv_object.dart';
import '../../../../tv/test/presentation/pages/home_tv_page_test.mocks.dart';

@GenerateMocks([
  TvNowPlayingCubit,
  TvPopularCubit,
  TvTopRatedCubit,
])
void main() {
  late MockTvNowPlayingCubit mockTvNowPlayingCubit;
  late MockTvPopularCubit mockTvPopularCubit;
  late MockTvTopRatedCubit mockTvTopRatedCubit;

  setUp(() {
    mockTvNowPlayingCubit = MockTvNowPlayingCubit();
    mockTvPopularCubit = MockTvPopularCubit();
    mockTvTopRatedCubit = MockTvTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvNowPlayingCubit>.value(
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
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockTvNowPlayingCubit.stream)
        .thenAnswer((_) => Stream.value(TvNowPlayingLoading()));
    when(mockTvNowPlayingCubit.state)
        .thenReturn(TvNowPlayingLoading());
    when(mockTvPopularCubit.stream)
        .thenAnswer((_) => Stream.value(TvPopularLoading()));
    when(mockTvPopularCubit.state).thenReturn(TvPopularLoading());
    when(mockTvTopRatedCubit.stream)
        .thenAnswer((_) => Stream.value(TvTopRatedLoading()));
    when(mockTvTopRatedCubit.state).thenReturn(TvTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byKey(const Key('center_progressbar'));

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    expect(centerFinder, findsNWidgets(3));
    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockTvNowPlayingCubit.stream).thenAnswer(
        (_) => Stream.value(TvNowPlayingLoaded(testTvList)));
    when(mockTvNowPlayingCubit.state)
        .thenReturn(TvNowPlayingLoaded(testTvList));
    when(mockTvPopularCubit.stream).thenAnswer(
        (_) => Stream.value(TvPopularLoaded(testTvList)));
    when(mockTvPopularCubit.state)
        .thenReturn(TvPopularLoaded(testTvList));
    when(mockTvTopRatedCubit.stream).thenAnswer(
        (_) => Stream.value(TvTopRatedLoaded(testTvList)));
    when(mockTvTopRatedCubit.state)
        .thenReturn(TvTopRatedLoaded(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTvNowPlayingCubit.stream).thenAnswer(
        (_) => Stream.value(const TvNowPlayingError('Failed')));
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
