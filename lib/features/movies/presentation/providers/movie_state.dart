import 'package:best_movies_app/features/movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final List<Movie> movies;
  final bool isLoading;
  final bool hasReachedEnd;
  final int currentPage;

  const MovieState({this.movies = const [], this.isLoading = false, this.hasReachedEnd = false, this.currentPage = 1});

  MovieState copyWith({List<Movie>? movies, bool? isLoading, bool? hasReachedEnd, int? currentPage}) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [movies, isLoading, hasReachedEnd, currentPage];
}
