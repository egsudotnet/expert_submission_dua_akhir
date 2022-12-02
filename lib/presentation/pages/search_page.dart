import 'package:ditonton/bloc/movies/search/search_movies_bloc.dart';
import 'package:ditonton/bloc/tvs/search/search_tvs_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
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
            title: TextField(
                  key: const Key('query_input'),
                  onChanged: (query) {
                    context.read<SearchMoviesBloc>().add(OnChangeMovieQuery(query));
                    context.read<SearchTvsBloc>().add(OnChangeTvQuery(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search title',
                  ),
                  textInputAction: TextInputAction.search,
                ),
          ),
          body: TabBarView(
            children: [
              ResultMovie(),
              ResultTv(), 
            ],
          ),
        ), 
    );
  }
}

class ResultMovie extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
              builder: (context, movie) {
                if (movie is SearchMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (movie is SearchMoviesHasData) {
                  return Expanded(
                    child: movie.result.length == 0 ? 
                      Center(child: Text("Empty")) :ListView.builder(
                      key: const Key('search_list'),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return MovieCard(movie.result[index]);
                      },
                      itemCount: movie.result.length,
                    ),
                  );
                } else if (movie is SearchMoviesError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      key: const Key('error_message'),
                      child: Text(movie.message),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ]
    );
  
  }
}

class ResultTv extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SearchTvsBloc, SearchTvsState>(
              builder: (context, movie) {
                if (movie is SearchTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (movie is SearchTvsHasData) {
                  return Expanded(
                    child: movie.result.length == 0 ? 
                      Center(child: Text("Empty")) :ListView.builder(
                      key: const Key('search_list'),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return TvCard(movie.result[index]);
                      },
                      itemCount: movie.result.length,
                    ),
                  );
                } else if (movie is SearchTvsError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      key: const Key('error_message'),
                      child: Text(movie.message),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ]
    );
  
  }
}