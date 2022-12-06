import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/movies/search_movies_bloc.dart';
import 'package:search/presentation/bloc/tvs/search_tvs_bloc.dart';
import 'package:widget/widget.dart';

part "search_movie_part.dart";
part "search_tv_part.dart";

class SearchPage extends StatelessWidget {
  static const routeName = '/search';

  const SearchPage({Key? key}) : super(key: key);
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
                  decoration: const InputDecoration(
                    hintText: 'Search title',
                  ),
                  textInputAction: TextInputAction.search,
                ),
          ),
          body: const TabBarView(
            children: [
              SearchMoviePart(),
              SearchTvPart(), 
            ],
          ),
        ), 
    );
  }
}