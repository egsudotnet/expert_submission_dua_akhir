part of "home_page.dart";

class ResultMovie extends StatelessWidget {
  const ResultMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing',
            style: kHeading6,
          ), 
          BlocBuilder<MovieNowPlayingCubit, MovieNowPlayingState>(
              builder: (context, data) {
            if (data is MovieNowPlayingLoading) {
              return const Center(
                key: Key('center_progressbar'),
                child: CircularProgressIndicator(),
              );
            } else if (data is MovieNowPlayingLoaded) {
              return _MovieList(data.nowPlayingMovie);
            } else {
              return const Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, popularMovieRoute),
          ),
          
          BlocBuilder<MoviePopularCubit, MoviePopularState>(
              builder: (context, data) {
            if (data is MoviePopularLoading) {
              return const Center(
                key: Key('center_progressbar'),
                child: CircularProgressIndicator(),
              );
            } else if (data is MoviePopularLoaded) {
              return _MovieList(data.popularMovie);
            } else {
              return const Text('Failed');
            }
          }),

          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, topRatedMovieRoute),
          ),
          BlocBuilder<MovieTopRatedCubit, MovieTopRatedState>(
              builder: (context, data) {
            if (data is MovieTopRatedLoading) {
              return const Center(
                key: Key('center_progressbar'),
                child: CircularProgressIndicator(),
              );
            } else if (data is MovieTopRatedLoaded) {
              return _MovieList(data.topRatedMovie);
            } else {
              return const Text('Failed');
            }
          }),
        ],
      ),
    );
  }
}


class _MovieList extends StatelessWidget {
  final List<Movie> movies;

  const _MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: ImageCard(pathImage: movie.posterPath ?? ""),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
