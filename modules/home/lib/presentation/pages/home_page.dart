import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/cubit/movie_now_playing_cubit.dart';
import 'package:movie/presentation/cubit/movie_popular_cubit.dart';
import 'package:movie/presentation/cubit/movie_top_rated_cubit.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';
import 'package:widget/widget.dart';

part 'home_movie_part.dart';
part 'home_tv_part.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

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
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, watchlistRoute);
                },
                leading: const Icon(Icons.save_alt),
                title: const Text('Watchlist'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, aboutRoute);
                },
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
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
          title: const Text('Ditonton'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchRoute);
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
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
            children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
          ),
        ),
      ),
    ],
  );
}
 
