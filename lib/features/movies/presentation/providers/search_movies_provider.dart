import 'dart:async';

import 'package:best_movies_app/features/movies/movies_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/search_movie.dart';
import 'movie_state.dart';

final searchMoviesProvider = StateNotifierProvider.autoDispose<SearchMoviesNotifier, MovieState>((ref) {
  final searchMovies = ref.watch(searchMoviesUseCaseProvider);
  return SearchMoviesNotifier(searchMovies: searchMovies);
});

class SearchMoviesNotifier extends StateNotifier<MovieState> {
  final SearchMovies searchMovies;
  Timer? _debounce;
  String _query = '';

  SearchMoviesNotifier({required this.searchMovies}) : super(const MovieState());

  String get query => _query;

  void onQueryChanged(String query) {
    _query = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.length >= 3) {
        search(query);
      } else {
        state = state.copyWith(movies: []);
      }
    });
  }

  Future<void> search(String query) async {
    state = state.copyWith(isLoading: true, movies: []);

    final result = await searchMovies(query);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false);
      },
      (movies) {
        state = state.copyWith(isLoading: false, movies: movies);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _query = '';
    state = const MovieState();
    super.dispose();
  }
}
