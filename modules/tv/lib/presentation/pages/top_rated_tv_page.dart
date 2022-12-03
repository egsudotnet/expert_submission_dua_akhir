import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
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
        title: const Text('Top Rated TVs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedCubit, TvTopRatedState>(
          builder: (context, data) {
            if (data is TvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvCard(
                    tv: data.topRatedTv[index],
                  );
                },
                itemCount: data.topRatedTv.length,
              );
            } else if (data is TvTopRatedError) {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
