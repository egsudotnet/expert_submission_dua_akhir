import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecase/get_detail_tv.dart';
import 'package:tv/domain/usecase/get_recommendation_tv.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetDetailTv detailTv;
  final GetRecommendationTv recommendationTv;

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
