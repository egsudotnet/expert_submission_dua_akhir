import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';
import 'package:tv/domain/entities/tv.dart';

import 'search_tv_page_test.mock.dart';

void main() {
  late MockSearchTvBloc mockTvBloc;

  setUpAll(() {
    registerFallbackValue(SearchTvStateFake());
    registerFallbackValue(SearchTvEventFake());
  });

  setUp(() {
    mockTvBloc = MockSearchTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvsBloc>.value(
      value: mockTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvBloc.stream)
        .thenAnswer((_) => Stream.value(SearchTvsLoading()));
    when(() => mockTvBloc.state).thenReturn(SearchTvsLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvBloc.state)
        .thenReturn(const SearchTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display error message when error',
      (WidgetTester tester) async {
    when(() => mockTvBloc.state)
        .thenReturn(const SearchTvsError('Error Message'));

    final emptyMessage = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(emptyMessage, findsOneWidget);
  });

  testWidgets('Page should display ListView when query id typed',
      (WidgetTester tester) async {
    when(() => mockTvBloc.state)
        .thenReturn(const SearchTvsHasData(<Tv>[]));

    final textfieldFinder = find.byKey(const Key('query_input'));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
    await tester.enterText(textfieldFinder, 'Venom');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    verify(() => mockTvBloc.add(const OnChangeTvQuery('Venom')));
  });
}
