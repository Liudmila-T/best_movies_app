import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:best_movies_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/strings.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton({super.key, required this.isFavorite, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final buttonBgColor = isFavorite ? context.buttonBg2Color : context.buttonBg1Color;
    final buttonBorderColor = isFavorite ? context.buttonText2Color : context.buttonBg1Color;
    final buttonTextColor = isFavorite ? context.buttonText2Color : context.buttonText1Color;

    return SizedBox(
      width: double.infinity,
      height: 47,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: buttonBorderColor),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          isFavorite ? AppStrings.removeFromFavorites : AppStrings.addToFavorites,
          style: AppTextStyles.buttonTitle16.copyWith(color: buttonTextColor),
        ),
      ),
    );
  }
}
