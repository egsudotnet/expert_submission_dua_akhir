import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'now_playing_tv_test.mocks.dart';

@GenerateMocks([TvNowPlayingCubit])
void main() {
  late MockTvNowPlayingCubit mockCubit;

  setUp(() {
    mockCubit = MockTvNowPlayingCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvNowPlayingCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(TvNowPlayingLoading()));
    when(mockCubit.state).thenReturn(TvNowPlayingLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(TvNowPlayingLoaded(testTvList)));
    when(mockCubit.state)
        .thenReturn(TvNowPlayingLoaded(testTvList));

    final listViewWidget = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvPage()));

    expect(listViewWidget, findsOneWidget);
  });

  testWidgets('Page should display error message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(const TvNowPlayingError('Error Message')));
    when(mockCubit.state)
        .thenReturn(const TvNowPlayingError('Error Message'));

    final textWidget = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const NowPlayingTvPage()));

    expect(textWidget, findsOneWidget);
  });
}
