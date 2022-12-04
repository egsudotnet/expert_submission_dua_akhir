part of "watchlist_page.dart";

class WatchlistTvPart extends StatelessWidget {
  const WatchlistTvPart({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, watchlist) {
            if (watchlist is WatchlistInitial) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  key: Key('empty_message'),
                  child: Text(
                    'Watchlist is Empty',
                  ),
                ),
              );
            } else if (watchlist is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (watchlist is WatchlistLoaded) {
              if (watchlist.watchlist.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final data = watchlist.watchlist[index];
                    final tvWatchlist = Tv.watchlist(
                      id: data.id,
                      overview: data.overview,
                      posterPath: data.posterPath,
                      title: data.title,
                      type: data.type,
                    );
                    if (data.type == 'Movie') {
                      return const SizedBox();
                    } else {
                      return TvCard(tv: tvWatchlist);
                    }
                  },
                  itemCount: watchlist.watchlist.length,
                );
              } else {
                return const Center(
                  key: Key('empty_message'),
                  child: Text(
                    'Watchlist is Empty',
                  ),
                );
              }
            } else if (watchlist is WatchlistMessage) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Center(
                  key: const Key('error_message'),
                  child: Text(
                    watchlist.watchlistMessage,
                  ),
                ),
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
