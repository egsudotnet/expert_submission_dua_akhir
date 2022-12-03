import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:tv/data/models/epidose_response.dart';
import 'package:tv/data/models/episode_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getNowPlayingTv();
  Future<TvDetailModel> getDetailTv(int id);
  Future<List<TvModel>> getTopRatedTv();
  Future<List<TvModel>> getRecommendationTv(int id);
  Future<List<TvModel>> searchTv(String query);
  Future<List<EpisodeModel>> getTvEpisode(int id, int season);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final IOClient client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final result =
          TvResponse.fromJson(json.decode(response.body)).tvList;
      for (var data in result) {
        data.type = 'Tv';
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    final response = await client.get(
        Uri.parse('$baseUrl/tv/on_the_air?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final result =
          TvResponse.fromJson(json.decode(response.body)).tvList;
      for (var data in result) {
        data.type = 'Tv';
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response = await client.get(
        Uri.parse('$baseUrl/tv/top_rated?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final result =
          TvResponse.fromJson(json.decode(response.body)).tvList;
      for (var data in result) {
        data.type = 'Tv';
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getDetailTv(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final result = TvDetailModel.fromJson(json.decode(response.body));
      result.type = 'Tv';
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getRecommendationTv(int id) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/tv/$id/recommendations?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final result =
          TvResponse.fromJson(json.decode(response.body)).tvList;
      for (var data in result) {
        data.type = 'Tv';
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/search/tv?api_key=$apiKey&query=$query'));
    if (response.statusCode == 200) {
      final result =
          TvResponse.fromJson(json.decode(response.body)).tvList;
      for (var data in result) {
        data.type = 'Tv';
      }
      return result;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getTvEpisode(int id, int season) async {
    final response = await client.get(Uri.parse(
        '$baseUrl/tv/$id/season/$season?api_key=$apiKey'));
    if (response.statusCode == 200) {
      return EpisodeResponse.fromJson(json.decode(response.body)).episodeList;
    } else {
      throw ServerException();
    }
  }
}
