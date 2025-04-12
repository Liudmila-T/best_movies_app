import 'package:best_movies_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/constans.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_movie_by_id.dart';
import 'domain/usecases/get_top_rated_movies.dart';

final _dio = Dio(BaseOptions(baseUrl: Constants.baseUrl))
  ..interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ),
  );

final dioProvider = Provider<Dio>((ref) => _dio);

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MovieRepositoryImpl(dio: dio);
});

final getTopRatedMoviesProvider = Provider<GetTopRatedMovies>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return GetTopRatedMovies(movieRepository: movieRepository);
});

final getMovieByIdProvider = Provider<GetMovieById>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return GetMovieById(movieRepository);
});
