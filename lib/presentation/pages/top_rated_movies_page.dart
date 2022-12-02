import 'package:ditonton/bloc_cubit/movies/movie_top_rated_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieTopRatedCubit>().fetchTopRatedMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedCubit, MovieTopRatedState>(
          builder: (context, data) {
            if (data is MovieTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is MovieTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.topRatedMovie[index];
                  return MovieCard(movie);
                },
                itemCount: data.topRatedMovie.length,
              );
            } else if (data is MovieTopRatedError) {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
