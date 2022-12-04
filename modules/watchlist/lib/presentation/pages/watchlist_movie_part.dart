part of "watchlist_page.dart";

class WatchlistMoviePart extends StatelessWidget {
  const WatchlistMoviePart({Key? key}) : super(key: key); 

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
                    if (data.type == 'Movie') {
                      return MovieCard(movie: data);
                    } else { 
                      return const SizedBox();
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
