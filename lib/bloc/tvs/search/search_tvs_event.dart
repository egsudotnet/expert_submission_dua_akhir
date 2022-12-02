part of 'search_tvs_bloc.dart';

@immutable
abstract class SearchTvsEvent extends Equatable {
  const SearchTvsEvent();

  @override
  List<Object?> get props => [];
}

class OnChangeTvQuery extends SearchTvsEvent {
  final String query;

  const OnChangeTvQuery(this.query);

  @override
  List<Object?> get props => [query];
}
