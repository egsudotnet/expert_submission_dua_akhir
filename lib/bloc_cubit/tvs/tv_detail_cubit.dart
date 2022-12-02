import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetTvDetail detailTv;
  final GetTvRecommendations recommendationTv;

  TvDetailCubit({
    required this.detailTv,
    required this.recommendationTv,
  }) : super(TvDetailInitial());

  void fetchDetailTv(int id) async {
    emit(TvDetailLoading());

    final result = await detailTv.execute(id);
    final recommendation = await recommendationTv.execute(id);

    result.fold(
      (failure) async {
        emit(TvDetailError(failure.message));
      },
      (detail) async {
        emit(TvRecommendationLoading());

        recommendation.fold(
          (failure) async {
            emit(TvRecommendationError(failure.message));
          },
          (recomendation) async {
            emit(TvDetailLoaded(detail, recomendation));
          },
        );
      },
    );
  }
}
