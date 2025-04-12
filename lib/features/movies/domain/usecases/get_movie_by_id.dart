import 'package:either_dart/either.dart';

import '../../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieById {
  final MovieRepository repository;

  GetMovieById(this.repository);

  Future<Either<Failure, Movie>> call(int id) {
    return repository.getMovieById(id);
  }
}
