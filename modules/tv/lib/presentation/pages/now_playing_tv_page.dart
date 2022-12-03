import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const routeName = '/now-playing-tv';
  const NowPlayingTvPage({Key? key}) : super(key: key);

  @override
  _NowPlayingTvPageState createState() => _NowPlayingTvPageState();
}

class _NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvNowPlayingCubit>().fetchNowPlayingTv(),
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
        child: BlocBuilder<TvNowPlayingCubit, TvNowPlayingState>(
          builder: (context, data) {
            if (data is TvNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvNowPlayingLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvCard(
                    tv: data.nowPlayingTv[index],
                  );
                },
                itemCount: data.nowPlayingTv.length,
              );
            } else if (data is TvNowPlayingError) {
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
