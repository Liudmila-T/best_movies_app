import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<Set<int>> {
  FavoritesNotifier() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteMovies') ?? [];
    state = Set<int>.from(favoriteIds.map((id) => int.parse(id)));
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = state.map((id) => id.toString()).toList();
    await prefs.setStringList('favoriteMovies', favoriteIds);
  }

  Future<void> toggleFavorite(int movieId) async {
    if (state.contains(movieId)) {
      state = {...state}..remove(movieId);
    } else {
      state = {...state, movieId};
    }

    await _saveFavorites();
  }

  bool isFavorite(int movieId) => state.contains(movieId);
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<int>>((ref) {
  return FavoritesNotifier();
});

final favoriteMovieProvider = Provider.family<bool, int>((ref, movieId) {
  final favorites = ref.watch(favoritesProvider);
  return favorites.contains(movieId);
});
