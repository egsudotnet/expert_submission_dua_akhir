import 'package:ditonton/bloc_cubit/tvs/tv_now_playing_cubit.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvNowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _TvNowPlayingPageState createState() => _TvNowPlayingPageState();
}

class _TvNowPlayingPageState extends State<TvNowPlayingPage> {
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
        title: Text('Now Playing Today Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingCubit, TvNowPlayingState>(
          builder: (context, data) {
            if (data is TvNowPlayingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvNowPlayingLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.nowPlayingTv[index];
                  return TvCard(tv);
                },
                itemCount: data.nowPlayingTv.length,
              );
            } else if (data is TvNowPlayingError) {
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
