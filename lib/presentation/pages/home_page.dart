import 'package:ditonton/bloc_cubit/movies/movie_now_playing_cubit.dart';
import 'package:ditonton/bloc_cubit/movies/movie_popular_cubit.dart';
import 'package:ditonton/bloc_cubit/movies/movie_top_rated_cubit.dart';
import 'package:ditonton/bloc_cubit/tvs/tv_now_playing_cubit.dart';
import 'package:ditonton/bloc_cubit/tvs/tv_popular_cubit.dart';
import 'package:ditonton/bloc_cubit/tvs/tv_top_rated_cubit.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_now_playing_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tvs_page.dart';
import 'package:ditonton/presentation/widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();  
    
    Future.microtask(() {
      context.read<MovieNowPlayingCubit>().fetchNowPlayingMovie();
      context.read<MoviePopularCubit>().fetchPopularMovie();
      context.read<MovieTopRatedCubit>().fetchTopRatedMovie();
    });

    Future.microtask(() {
      context.read<TvNowPlayingCubit>().fetchNowPlayingTv();
      context.read<TvPopularCubit>().fetchPopularTv();
      context.read<TvTopRatedCubit>().fetchTopRatedTv();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('Watchlist-Movies'),
                onTap: () {
                  Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
                },
              ),
              ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('Watchlist-TVs'),
                onTap: () {
                  Navigator.pushNamed(context, WatchlistTvsPage.ROUTE_NAME);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                },
                leading: Icon(Icons.info_outline),
                title: Text('About'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.movie)),
              Tab(icon: Icon(Icons.tv)),
            ],
          ),
          title: Text('Ditonton'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              ResultMovie(),
              ResultTv(),
            ],
          ),
        ),
      ),
    );
  }
}

Row _buildSubHeading({required String title, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: kHeading6,
      ),
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    ],
  );
}

class ResultMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing',
            style: kHeading6,
          ), 
          BlocBuilder<MovieNowPlayingCubit, MovieNowPlayingState>(
              builder: (context, data) {
            if (data is MovieNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is MovieNowPlayingLoaded) {
              return MovieList(data.nowPlayingMovie);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
          ),
          
          BlocBuilder<MoviePopularCubit, MoviePopularState>(
              builder: (context, data) {
            if (data is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is MoviePopularLoaded) {
              return MovieList(data.popularMovie);
            } else {
              return Text('Failed');
            }
          }),

          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
          ),
          BlocBuilder<MovieTopRatedCubit, MovieTopRatedState>(
              builder: (context, data) {
            if (data is MovieTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is MovieTopRatedLoaded) {
              return MovieList(data.topRatedMovie);
            } else {
              return Text('Failed');
            }
          }),
        ],
      ),
    );
  }
}

//BlocBuilder
class ResultTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubHeading(
            title: 'Now Playing',
            onTap: () =>
                Navigator.pushNamed(context, TvNowPlayingPage.ROUTE_NAME),
          ),
          BlocBuilder<TvNowPlayingCubit, TvNowPlayingState>(
              builder: (context, data) {
            if (data is TvNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvNowPlayingLoaded) {
              return TvList(data.nowPlayingTv);
            } else {
              return Text('Failed');
            }
          }),

          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
          ),
          BlocBuilder<TvPopularCubit, TvPopularState>(
              builder: (context, data) {
            if (data is TvPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvPopularLoaded) {
              return TvList(data.popularTv);
            } else {
              return Text('Failed');
            }
          }),

          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
          ),
          BlocBuilder<TvTopRatedCubit, TvTopRatedState>(
              builder: (context, data) {
            if (data is TvTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvTopRatedLoaded) {
              return TvList(data.topRatedTv);
            } else {
              return Text('Failed');
            }
          }),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ImageCard(pathImage: movie.posterPath ?? ""),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: ImageCard(pathImage: tv.posterPath ?? ""),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
