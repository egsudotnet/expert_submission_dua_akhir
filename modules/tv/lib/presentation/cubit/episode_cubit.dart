import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/episode.dart';
import 'package:tv/domain/usecase/get_tv_episode.dart';

part 'episode_state.dart';

class EpisodeCubit extends Cubit<EpisodeState> {
  final GetTvEpisode tvEpisode;

  EpisodeCubit({required this.tvEpisode}) : super(EpisodeInitial());

  void fetchEpisodeTv(int id, int season) async {
    emit(EpisodeLoading());

    final episode = await tvEpisode.execute(id, season);
    episode.fold(
      (failure) async {
        emit(EpisodeError(failure.message));
      },
      (data) async {
        if (data.isNotEmpty) {
          emit(EpisodeLoaded(data));
        } else {
          if (data.isEmpty) {
            emit(EpisodeInitial());
          }
        }
      },
    );
  }
}
