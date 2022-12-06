import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:widget/widget.dart';

part "watchlist_movie_part.dart";
part "watchlist_tv_part.dart";

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<WatchlistCubit>().fetchWatchlist();
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.tv)), 
              ],
            ),
            title: const Text('Watchlist'),
          ),
          body: const TabBarView(
            children: [
              WatchlistMoviePart(),
              WatchlistTvPart(), 
            ],
          ),
        ), 
    );
  }
}