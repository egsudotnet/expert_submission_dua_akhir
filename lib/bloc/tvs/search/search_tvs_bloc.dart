import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tvs_event.dart';
part 'search_tvs_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTvs searchTvs;

  SearchTvsBloc({required this.searchTvs})
      : super(SearchTvsInitial()) {
    on<OnChangeTvQuery>((event, emit) async {
      final query = event.query;

      emit(SearchTvsLoading());

      final result = await searchTvs.execute(query);

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

  EventTransformer<T> _debounce<T>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
