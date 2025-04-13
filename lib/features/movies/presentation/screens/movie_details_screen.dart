import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:best_movies_app/core/theme/app_text_styles.dart';
import 'package:best_movies_app/core/utils/date_format_extension.dart';
import 'package:best_movies_app/features/movies/presentation/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/navigation_provider.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constans.dart';
import '../../../../core/utils/strings.dart';
import '../providers/favorite_provider.dart';
import '../providers/movie_details_provider.dart';
import '../widgets/favorite_button.dart';
import '../widgets/icon_button.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailsProvider(movieId));
    final favorites = ref.watch(favoritesProvider);
    final navigationService = ref.watch(navigationProvider);

    return movieAsync.when(
      loading: () => Material(color: context.primaryBackgroundColor, child: AppCircularLoader()),
      error:
          (e, _) =>
              Material(color: context.primaryBackgroundColor, child: Center(child: Text('Error: ${e.toString()}'))),
      data: (movie) {
        final isFavorite = favorites.contains(movie.id);

        return Scaffold(
          backgroundColor: context.primaryBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, right: 16),
                  child: Row(
                    children: [
                      IconButtonWidget(icon: Assets.arrowLeft, onTap: () => navigationService.goBack()),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          movie.title,
                          style: AppTextStyles.title30.copyWith(color: context.textColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 46.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            '${Constants.imageBaseUrl}${movie.posterPath}',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          '${AppStrings.ratingLabel} ${movie.voteAverage}',
                          style: AppTextStyles.subtitle10.copyWith(color: context.textColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(movie.overview, style: AppTextStyles.text12.copyWith(color: context.textColor)),
                      const SizedBox(height: 16),
                      Text(
                        movie.releaseDate.toFormattedDate(),
                        style: AppTextStyles.text12.copyWith(color: context.textColor),
                      ),
                      const SizedBox(height: 16),
                      FavoriteButton(
                        isFavorite: isFavorite,
                        onTap: () {
                          ref.read(favoritesProvider.notifier).toggleFavorite(movieId);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
