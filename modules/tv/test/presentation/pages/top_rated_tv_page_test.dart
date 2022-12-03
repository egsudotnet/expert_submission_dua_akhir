import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TvTopRatedCubit])
void main() {
  late MockTvTopRatedCubit mockCubit;

  setUp(() {
    mockCubit = MockTvTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(TvTopRatedLoading()));
    when(mockCubit.state).thenReturn(TvTopRatedLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display ListView when data loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(TvTopRatedLoaded(testTvList)));
    when(mockCubit.state).thenReturn(TvTopRatedLoaded(testTvList));

    final listViewWidget = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(listViewWidget, findsOneWidget);
  });

  testWidgets('Page should display error message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(const TvTopRatedError('Error Message')));
    when(mockCubit.state)
        .thenReturn(const TvTopRatedError('Error Message'));

    final textWidget = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(textWidget, findsOneWidget);
  });
}
