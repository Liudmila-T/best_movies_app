import 'package:best_movies_app/screens/movie_details_screen.dart';
import 'package:best_movies_app/screens/movies_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const MoviesListScreen();
        },
      ),
      GoRoute(
        path: '/movie/:id',
        builder: (context, state) {
          final String movieId = state.pathParameters['id']!;
          return MovieDetailsScreen(id: movieId);
        },
      ),
    ],
  );
}
