import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/movie.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    required int id,
    @JsonKey(name: 'original_title') required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    required String overview,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'vote_average') required double voteAverage,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
}

extension MovieModelMapper on MovieModel {
  Movie toEntity() {
    return Movie(
      id: id,
      title: originalTitle,
      posterPath: posterPath,
      overview: overview,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
    );
  }
}
