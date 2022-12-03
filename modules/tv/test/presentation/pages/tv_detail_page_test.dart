import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/cubit/episode_cubit.dart';
import 'package:tv/presentation/cubit/tv_detail_cubit.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/widget/episode_card_list.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_tv_object.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([
  TvDetailCubit,
  WatchlistCubit,
  EpisodeCubit,
])
void main() {
  late MockTvDetailCubit mockTvDetailCubit;
  late MockWatchlistCubit mockWatchlistCubit;
  late MockEpisodeCubit mockEpisodeCubit;

  setUp(() {
    mockTvDetailCubit = MockTvDetailCubit();
    mockWatchlistCubit = MockWatchlistCubit();
    mockEpisodeCubit = MockEpisodeCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailCubit>.value(
      value: mockTvDetailCubit,
      child: BlocProvider<WatchlistCubit>.value(
        value: mockWatchlistCubit,
        child: BlocProvider<EpisodeCubit>.value(
          value: mockEpisodeCubit,
          child: MaterialApp(
            home: body,
          ),
        ),
      ),
    );
  }

  testWidgets(
    'should display proggress bar when movie and recommendation loading',
    (WidgetTester tester) async {
      when(mockTvDetailCubit.stream)
          .thenAnswer((_) => Stream.value(TvDetailLoading()));
      when(mockTvDetailCubit.state).thenReturn(TvDetailLoading());
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(WatchlistInitial()));
      when(mockWatchlistCubit.state).thenReturn(WatchlistInitial());

      final loadingFinder = find.byType(CircularProgressIndicator);

      await tester
          .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      expect(loadingFinder, findsOneWidget);
    },
  );
  testWidgets(
    'should display error message when get data is error',
    (WidgetTester tester) async {
      when(mockTvDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const TvDetailError('Error Message')));
      when(mockTvDetailCubit.state)
          .thenReturn(const TvDetailError('Error Message'));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(WatchlistInitial()));
      when(mockWatchlistCubit.state).thenReturn(WatchlistInitial());

      final errorFinder = find.text('Error Message');

      await tester
          .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display add icon when tv  not added to watchlist",
    (WidgetTester tester) async {
      when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
          const TvDetailLoaded(testTvDetail, <Tv>[])));
      when(mockTvDetailCubit.state).thenReturn(
          const TvDetailLoaded(testTvDetail, <Tv>[]));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
      when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));
      when(mockEpisodeCubit.stream)
          .thenAnswer((_) => Stream.value(EpisodeLoaded(testEpisodeList)));
      when(mockEpisodeCubit.state).thenReturn(EpisodeLoaded(testEpisodeList));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display check icon when tv  added to watchlist",
    (WidgetTester tester) async {
      when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
          const TvDetailLoaded(testTvDetail, <Tv>[])));
      when(mockTvDetailCubit.state).thenReturn(
          const TvDetailLoaded(testTvDetail, <Tv>[]));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistStatus(true)));
      when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(true));
      when(mockEpisodeCubit.stream)
          .thenAnswer((_) => Stream.value(EpisodeLoaded(testEpisodeList)));
      when(mockEpisodeCubit.state).thenReturn(EpisodeLoaded(testEpisodeList));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
        const TvDetailLoaded(testTvDetail, <Tv>[])));
    when(mockTvDetailCubit.state).thenReturn(
        const TvDetailLoaded(testTvDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));
    when(mockWatchlistCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMessage('Added to Watchlist')));
    when(mockWatchlistCubit.state)
        .thenReturn(const WatchlistMessage('Added to Watchlist'));

    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
        const TvDetailLoaded(testTvDetail, <Tv>[])));
    when(mockTvDetailCubit.state).thenReturn(
        const TvDetailLoaded(testTvDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(true)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(true));
    when(mockWatchlistCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMessage('Removed from Watchlist')));
    when(mockWatchlistCubit.state)
        .thenReturn(const WatchlistMessage('Removed from Watchlist'));

    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
        const TvDetailLoaded(testTvDetail, <Tv>[])));
    when(mockTvDetailCubit.state).thenReturn(
        const TvDetailLoaded(testTvDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistMessage('Failed')));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistMessage('Failed'));

    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when removed from watchlist failed',
      (WidgetTester tester) async {
    when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
        const TvDetailLoaded(testTvDetail, <Tv>[])));
    when(mockTvDetailCubit.state).thenReturn(
        const TvDetailLoaded(testTvDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(true)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(true));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistMessage('Failed')));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistMessage('Failed'));

    await tester
        .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
    "should display Episode Card List Widget",
    (WidgetTester tester) async {
      when(mockTvDetailCubit.stream).thenAnswer((_) => Stream.value(
          const TvDetailLoaded(testTvDetail, <Tv>[])));
      when(mockTvDetailCubit.state).thenReturn(
          const TvDetailLoaded(testTvDetail, <Tv>[]));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
      when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));
      when(mockEpisodeCubit.stream)
          .thenAnswer((_) => Stream.value(EpisodeLoaded(testEpisodeList)));
      when(mockEpisodeCubit.state).thenReturn(EpisodeLoaded(testEpisodeList));

      final seasonTabbar = find.byType(TabBarView);
      final detailEpisodeCard = find.byType(EpisodeCardList);

      await tester
          .pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(seasonTabbar, findsOneWidget);
      await tester.pump();

      expect(detailEpisodeCard, findsOneWidget);
    },
  );
}
