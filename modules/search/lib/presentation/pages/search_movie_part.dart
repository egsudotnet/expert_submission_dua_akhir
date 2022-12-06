part of "search_page.dart";

class SearchMoviePart extends StatelessWidget {
  const SearchMoviePart({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
              builder: (context, data) {
                if (data is SearchMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is SearchMoviesHasData) {
                  return Expanded(
                    child: data.result.isEmpty ? 
                      const Center(child: Text("Empty")) :
                      ListView.builder(
                      key: const Key('search_list'),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return MovieCard(movie: data.result[index]);
                      },
                      itemCount: data.result.length,
                    ),
                  );
                } else if (data is SearchMoviesError) {
                  return const Expanded(
                    child: Center(child: Text("Empty"))
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ]
    );
  
  }
}
