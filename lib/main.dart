import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/presentation/pages/home_page.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';
import 'package:watchlist/watchlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init(await getHttpClient());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<EpisodeCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvNowPlayingCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvsBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchPage());
            // case SearchTvPage.routeName:
            //   return MaterialPageRoute(builder: (_) => SearchTvPage());
            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            // case HomeTvPage.routeName:
            //   return MaterialPageRoute(builder: (_) => HomeTvPage());
            case NowPlayingTvPage.routeName:
              return MaterialPageRoute(builder: (_) => NowPlayingTvPage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case PopularTvPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
