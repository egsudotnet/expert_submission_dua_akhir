part of "home_page.dart";

class ResultTv extends StatelessWidget {
  const ResultTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubHeading(
            title: 'Now Playing',
            onTap: () =>
                Navigator.pushNamed(context, nowPlayingTvRoute),
          ),
          BlocBuilder<TvNowPlayingCubit, TvNowPlayingState>(
              builder: (context, data) {
            if (data is TvNowPlayingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvNowPlayingLoaded) {
              return _TvList(data.nowPlayingTv);
            } else {
              return const Text('Failed');
            }
          }),

          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, popularTvRoute),
          ),
          BlocBuilder<TvPopularCubit, TvPopularState>(
              builder: (context, data) {
            if (data is TvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvPopularLoaded) {
              return _TvList(data.popularTv);
            } else {
              return const Text('Failed');
            }
          }),

          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, topRatedTvRoute),
          ),
          BlocBuilder<TvTopRatedCubit, TvTopRatedState>(
              builder: (context, data) {
            if (data is TvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TvTopRatedLoaded) {
              return _TvList(data.topRatedTv);
            } else {
              return const Text('Failed');
            }
          }),
        ],
      ),
    );
  }
}

class _TvList extends StatelessWidget {
  final List<Tv> tvs;

  const _TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: ImageCard(pathImage: tv.posterPath ?? ""),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
