import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';
import 'package:movie/domain/entities/movie.dart';

import 'search_page_test.mock.dart'; 

void main() {
  late MockSearchMoviesBloc mockMovieBloc; 

  setUpAll(() {
    registerFallbackValue(SearchMoviesStateFake());
    registerFallbackValue(SearchMoviesEventFake()); 
  });

  setUp(() {
    mockMovieBloc = MockSearchMoviesBloc();
  }); 

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchMoviesBloc>.value(
        value: mockMovieBloc,
        child: MaterialApp(
            home: body,
          )
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.stream)
        .thenAnswer((_) => Stream.value(SearchMoviesLoading()));
    when(() => mockMovieBloc.state).thenReturn(SearchMoviesLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display SearchMoviesPart when data is loaded',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.state)
        .thenReturn(const SearchMoviesHasData(<Movie>[]));

    final searchMoviePartFinder = find.byType(SearchPage);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(searchMoviePartFinder, findsOneWidget);
  });

  testWidgets('Page should display error message when error',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.state)
        .thenReturn(const SearchMoviesError('Error Message'));

    final emptyMessage = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(emptyMessage, findsOneWidget);
  });
}
