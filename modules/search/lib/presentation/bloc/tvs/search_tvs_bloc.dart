import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';

part 'search_tvs_event.dart';
part 'search_tvs_state.dart';

class SearchTvsBloc
    extends Bloc<SearchTvEvent, SearchTvsState> {
  final SearchTv searchTv;

  SearchTvsBloc({required this.searchTv})
      : super(SearchTvInitial()) {
    on<OnChangeTvQuery>((event, emit) async {
      final query = event.query;

      emit(SearchTvsLoading());

      final result = await searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SearchTvsError(failure.message));
        },
        (result) {
          emit(SearchTvsHasData(result));
        },
      );
    }, transformer: _debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> _debounce<T>(
          Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
