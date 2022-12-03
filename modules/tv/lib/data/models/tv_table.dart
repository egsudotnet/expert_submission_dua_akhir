import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

// ignore: must_be_immutable
class TvTable extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  String type;

  TvTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.type,
  });

  factory TvTable.fromJson(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        title: map['name'],
        overview: map['overview'],
        posterPath: map['poster_path'],
        type: map['type'] ?? '',
      );

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
        id: tv.id,
        title: tv.title,
        posterPath: tv.posterPath,
        overview: tv.overview,
        type: tv.type,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'poster_path': posterPath,
        'type': type,
      };

  Tv toEntity() => Tv.watchlist(
        id: id!,
        overview: overview,
        posterPath: posterPath,
        title: title!,
        type: type,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        type,
      ];
}
