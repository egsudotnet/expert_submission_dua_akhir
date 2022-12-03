import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/tvs/search_tvs_bloc.dart';

class MockSearchTvBloc
    extends MockBloc<SearchTvEvent, SearchTvsState>
    implements SearchTvsBloc {}

class SearchTvStateFake extends Fake implements SearchTvsState {}

class SearchTvEventFake extends Fake implements SearchTvEvent {}
