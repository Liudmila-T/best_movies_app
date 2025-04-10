import 'package:best_movies_app/core/errors/failure.dart';
import 'package:best_movies_app/features/movies/domain/entities/movie.dart';
import 'package:either_dart/either.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getTopRatedMovies(int page);
  Future<Either<Failure, Movie>> getMovieById(int id);
}
