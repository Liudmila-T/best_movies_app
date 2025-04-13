import 'package:go_router/go_router.dart';

import '../features/movies/presentation/screens/movie_details_screen.dart';
import '../features/movies/presentation/screens/movies_list_screen.dart';
import '../features/movies/presentation/screens/search_movies_screen.dart';

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
          final movieId = int.parse(state.pathParameters['id']!);
          return MovieDetailsScreen(movieId: movieId);
        },
      ),
      GoRoute(path: '/search', builder: (context, state) => const SearchMoviesScreen()),
    ],
  );
}

class NavigationService {
  final GoRouter goRouter;

  NavigationService(this.goRouter);

  void goToMovieDetails(int movieId) {
    goRouter.push('/movie/$movieId');
  }

  void goSearchMovies() {
    goRouter.push('/search');
  }

  void goBack() {
    goRouter.pop();
  }
}
