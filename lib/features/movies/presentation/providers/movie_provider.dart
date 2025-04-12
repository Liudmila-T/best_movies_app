import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_top_rated_movies.dart';
import '../../movies_injection.dart';
import 'movie_state.dart';

final movieListProvider = StateNotifierProvider<MovieListNotifier, MovieState>((ref) {
  final getTopRatedMovies = ref.watch(getTopRatedMoviesProvider);
  return MovieListNotifier(getTopRatedMovies: getTopRatedMovies);
});

class MovieListNotifier extends StateNotifier<MovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieListNotifier({required this.getTopRatedMovies}) : super(const MovieState());

  Future<void> fetchTopRatedMovies() async {
    if (state.isLoading || state.hasReachedEnd) return;

    state = state.copyWith(isLoading: true);

    final nextPage = state.currentPage;
    final result = await getTopRatedMovies(nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false);
      },
      (newMovies) {
        final hasReachedEnd = newMovies.isEmpty;

        state = state.copyWith(
          isLoading: false,
          movies: [...state.movies, ...newMovies],
          hasReachedEnd: hasReachedEnd,
          currentPage: nextPage + 1,
        );
      },
    );
  }

  void reset() {
    state = const MovieState();
  }
}
