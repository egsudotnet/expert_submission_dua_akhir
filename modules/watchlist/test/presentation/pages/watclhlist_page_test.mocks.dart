// Mocks generated by Mockito 5.3.0 from annotations
// in watchlist/test/presentation/pages/watclhlist_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:flutter_bloc/flutter_bloc.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie.dart' as _i8;
import 'package:watchlist/domain/usecases/get_watchlist.dart' as _i2;
import 'package:watchlist/domain/usecases/get_watchlist_status.dart' as _i3;
import 'package:watchlist/domain/usecases/remove_watchlist.dart' as _i5;
import 'package:watchlist/domain/usecases/save_watchlist.dart' as _i4;
import 'package:watchlist/presentation/cubit/watchlist_cubit.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetWatchlist_0 extends _i1.SmartFake implements _i2.GetWatchlist {
  _FakeGetWatchlist_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGetWatchListStatus_1 extends _i1.SmartFake
    implements _i3.GetWatchListStatus {
  _FakeGetWatchListStatus_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSaveWatchlist_2 extends _i1.SmartFake implements _i4.SaveWatchlist {
  _FakeSaveWatchlist_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRemoveWatchlist_3 extends _i1.SmartFake
    implements _i5.RemoveWatchlist {
  _FakeRemoveWatchlist_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeWatchlistState_4 extends _i1.SmartFake
    implements _i6.WatchlistState {
  _FakeWatchlistState_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [WatchlistCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistCubit extends _i1.Mock implements _i6.WatchlistCubit {
  MockWatchlistCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlist get watchlist => (super.noSuchMethod(
          Invocation.getter(#watchlist),
          returnValue: _FakeGetWatchlist_0(this, Invocation.getter(#watchlist)))
      as _i2.GetWatchlist);
  @override
  _i3.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
              returnValue: _FakeGetWatchListStatus_1(
                  this, Invocation.getter(#getWatchListStatus)))
          as _i3.GetWatchListStatus);
  @override
  _i4.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
              returnValue:
                  _FakeSaveWatchlist_2(this, Invocation.getter(#saveWatchlist)))
          as _i4.SaveWatchlist);
  @override
  _i5.RemoveWatchlist get removeWatchlist => (super.noSuchMethod(
          Invocation.getter(#removeWatchlist),
          returnValue:
              _FakeRemoveWatchlist_3(this, Invocation.getter(#removeWatchlist)))
      as _i5.RemoveWatchlist);
  @override
  _i6.WatchlistState get state => (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeWatchlistState_4(this, Invocation.getter(#state)))
      as _i6.WatchlistState);
  @override
  _i7.Stream<_i6.WatchlistState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: _i7.Stream<_i6.WatchlistState>.empty())
          as _i7.Stream<_i6.WatchlistState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void loadWatchlistStatus(int? id) =>
      super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValueForMissingStub: null);
  @override
  void fetchWatchlist() =>
      super.noSuchMethod(Invocation.method(#fetchWatchlist, []),
          returnValueForMissingStub: null);
  @override
  void addWatchlist(_i8.Movie? movie) =>
      super.noSuchMethod(Invocation.method(#addWatchlist, [movie]),
          returnValueForMissingStub: null);
  @override
  void deleteWatchlist(int? id) =>
      super.noSuchMethod(Invocation.method(#deleteWatchlist, [id]),
          returnValueForMissingStub: null);
  @override
  void emit(_i6.WatchlistState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i9.Change<_i6.WatchlistState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i7.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
}