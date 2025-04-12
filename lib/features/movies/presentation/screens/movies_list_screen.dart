import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/navigation_provider.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../core/utils/assets.dart';
import '../providers/favorite_provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/icon_button.dart';
import '../widgets/movie_grid_item.dart';

class MoviesListScreen extends ConsumerStatefulWidget {
  const MoviesListScreen({super.key});

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends ConsumerState<MoviesListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieListProvider.notifier).fetchTopRatedMovies();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      ref.read(movieListProvider.notifier).fetchTopRatedMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = ref.watch(navigationProvider);
    final movies = ref.watch(movieListProvider).movies;
    final themeMode = ref.read(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      body:
          movies.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 6,
                          top: MediaQuery.paddingOf(context).top,
                          bottom: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Movie', style: AppTextStyles.title30.copyWith(color: context.textColor)),
                            Row(
                              children: [
                                IconButtonWidget(icon: Assets.search, onTap: () {}),
                                IconButtonWidget(
                                  icon: isDarkMode ? Assets.moon : Assets.sun,
                                  onTap: () {
                                    ref.read(themeModeProvider.notifier).toggleTheme();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16.5),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movieId = movies[index].id;
                          final isFavorite = ref.watch(favoriteMovieProvider(movieId));
                          return MovieGridItem(
                            movie: movies[index],
                            isFavorite: isFavorite,
                            onTapFavorite: () {
                              ref.read(favoritesProvider.notifier).toggleFavorite(movieId);
                            },
                            onTap: () {
                              navigationService.goToMovieDetails(movieId);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
