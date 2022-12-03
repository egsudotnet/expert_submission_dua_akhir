part of "search_page.dart";


class SearchTvPart extends StatelessWidget {
  const SearchTvPart({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SearchTvsBloc, SearchTvsState>(
              builder: (context, data) {
                if (data is SearchTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is SearchTvsHasData) {
                  return Expanded(
                    child: data.result.isEmpty ? 
                      const Center(child: Text("Empty")) :ListView.builder(
                      key: const Key('search_list'),
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return TvCard(tv : data.result[index]);
                      },
                      itemCount: data.result.length,
                    ),
                  );
                } else if (data is SearchTvsError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      key: const Key('error_message'),
                      child: Text(data.message),
                    ),
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