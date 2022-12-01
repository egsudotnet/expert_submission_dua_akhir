import 'dart:async';
 
enum SearchEvent { Increment, Decrement }
 
class SearchBloc {
  int search = 0;
 
  StreamController<SearchEvent> _eventController =
      StreamController<SearchEvent>();
  StreamSink get eventSink => _eventController.sink;
 
  StreamController<int> _searchController = StreamController<int>();
  StreamSink<int> get _searchSink => _searchController.sink;
  Stream<int> get searchStream => _searchController.stream;
 
  SearchBloc() {
    _eventController.stream.listen(_mapEventToState);
  }
 
  void _mapEventToState(SearchEvent event) {
    if (event == SearchEvent.Increment) {
      search++;
    } else {
      search--;
    }
 
    _searchSink.add(search);
  }
 
  void dispose() {
    _eventController.close();
    _searchController.close();
  }
}