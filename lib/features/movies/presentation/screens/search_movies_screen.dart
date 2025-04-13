import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/providers/navigation_provider.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/strings.dart';
import '../providers/favorite_provider.dart';
import '../providers/search_movies_provider.dart';
import '../widgets/icon_button.dart';
import '../widgets/movie_grid_item.dart';

class SearchMoviesScreen extends ConsumerWidget {
  const SearchMoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.watch(navigationProvider);
    final state = ref.watch(searchMoviesProvider);
    final notifier = ref.read(searchMoviesProvider.notifier);
    final query = ref.watch(searchMoviesProvider.notifier).query;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 33),
              child: Row(
                children: [
                  IconButtonWidget(icon: Assets.arrowLeft, onTap: () => navigationService.goBack()),
                  const SizedBox(width: 8),
                  Text(AppStrings.search, style: AppTextStyles.title30.copyWith(color: context.textColor)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  TextField(
                    onChanged: notifier.onQueryChanged,
                    decoration: InputDecoration(
                      hintText: AppStrings.search,
                      hintStyle: AppTextStyles.text18Medium.copyWith(color: context.textColor.withOpacity(0.2)),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(Assets.search, color: context.textColor, width: 20, height: 20),
                      ),
                      fillColor: context.searchColor,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state.isLoading)
                    Center(child: CircularProgressIndicator(color: context.textColor))
                  else if (query.trim().length < 3)
                    const SizedBox.shrink()
                  else
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppStrings.searchResult} (${state.movies.length})',
                            style: AppTextStyles.text18Medium.copyWith(color: context.textColor),
                          ),
                          const SizedBox(height: 24),
                          if (state.movies.isEmpty)
                            SvgPicture.asset(Assets.emptyMovieList, color: context.textColor)
                          else
                            Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: state.movies.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.58,
                                ),
                                itemBuilder: (context, index) {
                                  final movie = state.movies[index];
                                  final movieId = movie.id;
                                  final isFavorite = ref.watch(favoriteMovieProvider(movieId));

                                  return MovieGridItem(
                                    movie: movie,
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
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
