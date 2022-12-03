part of 'search_tvs_bloc.dart';

@immutable
abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object?> get props => [];
}

class OnChangeTvQuery extends SearchTvEvent {
  final String query;

  const OnChangeTvQuery(this.query);

  @override
  List<Object?> get props => [query];
}
