import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:best_movies_app/core/theme/app_text_styles.dart';
import 'package:best_movies_app/core/utils/constans.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'favorite_icon_button.dart';

class MovieGridItem extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onTapFavorite;
  final VoidCallback onTap;

  const MovieGridItem({
    super.key,
    required this.movie,
    this.isFavorite = false,
    required this.onTapFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    '${Constants.imageBaseUrl}${movie.posterPath}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 11,
                  right: 14,
                  child: FavoriteIconButton(
                    color: isFavorite ? context.activeFavoriteColor : context.inactiveFavoriteColor,
                    onTap: onTapFavorite,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title14.copyWith(color: context.textColor),
          ),
          Text('Rating: ${movie.voteAverage}', style: AppTextStyles.subtitle10.copyWith(color: context.textColor)),
        ],
      ),
    );
  }
}
