// Mocks generated by Mockito 5.3.0 from annotations
// in tv/test/presentation/pages/now_playing_tv_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/usecase/get_now_playing_tv.dart' as _i2;
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart'
    as _i3;

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

class _FakeGetNowPlayingTv_0 extends _i1.SmartFake
    implements _i2.GetNowPlayingTv {
  _FakeGetNowPlayingTv_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTvNowPlayingState_1 extends _i1.SmartFake
    implements _i3.TvNowPlayingState {
  _FakeTvNowPlayingState_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvNowPlayingCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvNowPlayingCubit extends _i1.Mock
    implements _i3.TvNowPlayingCubit {
  MockTvNowPlayingCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingTv get nowPlayingTv =>
      (super.noSuchMethod(Invocation.getter(#nowPlayingTv),
              returnValue: _FakeGetNowPlayingTv_0(
                  this, Invocation.getter(#nowPlayingTv)))
          as _i2.GetNowPlayingTv);
  @override
  _i3.TvNowPlayingState get state => (super.noSuchMethod(
          Invocation.getter(#state),
          returnValue:
              _FakeTvNowPlayingState_1(this, Invocation.getter(#state)))
      as _i3.TvNowPlayingState);
  @override
  _i4.Stream<_i3.TvNowPlayingState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: _i4.Stream<_i3.TvNowPlayingState>.empty())
          as _i4.Stream<_i3.TvNowPlayingState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void fetchNowPlayingTv() =>
      super.noSuchMethod(Invocation.method(#fetchNowPlayingTv, []),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.TvNowPlayingState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i5.Change<_i3.TvNowPlayingState>? change) =>
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
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: _i4.Future<void>.value(),
      returnValueForMissingStub: _i4.Future<void>.value()) as _i4.Future<void>);
}