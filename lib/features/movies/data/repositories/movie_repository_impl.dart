import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/constans.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio dio;

  MovieRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page) async {
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/movie/top_rated',
        queryParameters: {'api_key': Constants.apiKey, 'page': page},
      );

      if (response.statusCode == 200) {
        final List<MovieModel> movies =
            (response.data['results'] as List).map((movie) => MovieModel.fromJson(movie)).toList();

        return Right(movies.map((model) => model.toEntity()).toList());
      } else {
        return Left(Failure(message: 'Failed to load top rated movies', code: response.statusCode));
      }
    } catch (e) {
      return Left(Failure(message: 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieById(int id) async {
    try {
      final response = await dio.get('${Constants.baseUrl}/movie/$id', queryParameters: {'api_key': Constants.apiKey});

      if (response.statusCode == 200) {
        final movie = MovieModel.fromJson(response.data);
        return Right(movie.toEntity());
      } else {
        return Left(Failure(message: 'Failed to load movie details', code: response.statusCode));
      }
    } catch (e) {
      return Left(Failure(message: 'Error: ${e.toString()}'));
    }
  }

  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/search/movie',
        queryParameters: {'api_key': Constants.apiKey, 'query': query},
      );

      if (response.statusCode == 200) {
        final movies = (response.data['results'] as List).map((json) => MovieModel.fromJson(json)).toList();
        return Right(movies.map((movie) => movie.toEntity()).toList());
      } else {
        return Left(Failure(message: 'Failed to load movies', code: response.statusCode));
      }
    } catch (e) {
      return Left(Failure(message: 'Error: ${e.toString()}'));
    }
  }
}
