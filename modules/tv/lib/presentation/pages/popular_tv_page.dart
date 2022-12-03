import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular-tv';
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
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
        title: const Text('Popular TVs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularCubit, TvPopularState>(
          builder: (context, data) {
            if (data is TvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvCard(
                    tv: data.popularTv[index],
                  );
                },
                itemCount: data.popularTv.length,
              );
            } else if (data is TvPopularError) {
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
