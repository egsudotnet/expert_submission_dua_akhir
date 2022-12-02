import 'package:ditonton/bloc_cubit/tvs/tv_popular_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvsPageState createState() => _PopularTvsPageState();
}

class _PopularTvsPageState extends State<PopularTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvPopularCubit>().fetchPopularTv(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Today Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularCubit, TvPopularState>(
          builder: (context, data) {
            if (data is TvPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.popularTv[index];
                  return TvCard(tv);
                },
                itemCount: data.popularTv.length,
              );
            } else if (data is TvPopularError) {
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
