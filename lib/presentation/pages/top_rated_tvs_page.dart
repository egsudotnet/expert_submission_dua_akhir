import 'package:ditonton/bloc_cubit/tvs/tv_top_rated_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TopRatedTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvTopRatedCubit>().fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedCubit, TvTopRatedState>(
          builder: (context, data) {
            if (data is TvTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.topRatedTv[index];
                  return TvCard(tv);
                },
                itemCount: data.topRatedTv.length,
              );
            } else if (data is TvTopRatedError) {
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
