import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedMovies {
  final MovieRepository movieRepository;

  GetTopRatedMovies({required this.movieRepository});

  Future<Either<Failure, List<Movie>>> call(int page) {
    return movieRepository.getTopRatedMovies(page);
  }
}
