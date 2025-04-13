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
import '../widgets/app_loader.dart';
import '../widgets/icon_button.dart';
import '../widgets/movie_grid_item.dart';

class SearchMoviesScreen extends ConsumerWidget {
  const SearchMoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.watch(navigationProvider);
    final state = ref.watch(searchMoviesProvider);
    final notifier = ref.read(searchMoviesProvider.notifier);
    final query = notifier.query;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 33, left: 16, right: 16),
              child: Row(
                children: [
                  IconButtonWidget(icon: Assets.arrowLeft, onTap: () => navigationService.goBack()),
                  const SizedBox(width: 8),
                  Text(AppStrings.search, style: AppTextStyles.title30.copyWith(color: context.textColor)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                onChanged: notifier.onQueryChanged,
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  hintStyle: AppTextStyles.text18Medium.copyWith(
                    color: context.textColor.withAlpha(51), // opacity 0.2 (255 * 0.2 = 51)
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      Assets.search,
                      colorFilter: ColorFilter.mode(context.textColor, BlendMode.srcIn),
                      width: 20,
                      height: 20,
                    ),
                  ),
                  fillColor: context.searchColor,
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return const Center(child: AppCircularLoader());
                  }
                  if (query.trim().length < 3) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStrings.searchResult} (${state.movies.length})',
                          style: AppTextStyles.text18Medium.copyWith(color: context.textColor),
                        ),
                        const SizedBox(height: 24),
                        state.movies.isEmpty
                            ? Expanded(
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.emptyMovieList,
                                  colorFilter: ColorFilter.mode(context.textColor, BlendMode.srcIn),
                                ),
                              ),
                            )
                            : Expanded(
                              child: GridView.builder(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
