import 'package:flutter/material.dart';

class _AppColors {
  static const Color _darkBgColor = Color(0xFF111111);
  static const Color lightBgColor = Color(0xFFFFFFFF);

  static const Color _darkTextColor = Color(0xFFFFFFFF);
  static const Color _lightTextColor = Color(0xFF000000);

  static const Color _darkActiveFavoriteColor = Color(0xFFF2C94C);
  static const Color _lightActiveFavoriteColor = Color(0xFFF2C94C);

  static const Color _darkStarColor = Color(0x99FFFFFF);
  static const Color _lightStarColor = Color(0x99FFFFFF);

  static const Color _darkTitleColor = Color(0xFFFFFFFF);
  static const Color _lightTitleColor = Color(0xFFFFFFFF);

  static const Color _darkButtonBg1Color = Color(0xFFF2C94C);
  static const Color _lightButtonBg1Color = Color(0xFFF2C94C);

  static const Color _darkButtonText1Color = Color(0xFF111111);
  static const Color _lightButtonText1Color = Color(0xFF111111);

  static const Color _darkButtonBg2Color = Color(0xFFFFFFFF);
  static const Color _lightButtonBg2Color = Color(0xFF000000);

  static const Color _darkButtonText2Color = Color(0xFFFFFFFF);
  static const Color _lightButtonText2Color = Color(0xFF000000);

  static const Color _darkSearchColor = Color(0xFF000000);
  static const Color _lightSearchColor = Color(0xFFF1F1F1);
}

extension AppColorScheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get primaryBackgroundColor => isDark ? _AppColors._darkBgColor : _AppColors.lightBgColor;

  Color get textColor => isDark ? _AppColors._darkTextColor : _AppColors._lightTextColor;

  Color get activeFavoriteColor => isDark ? _AppColors._darkActiveFavoriteColor : _AppColors._lightActiveFavoriteColor;

  Color get starColor => isDark ? _AppColors._darkStarColor : _AppColors._lightStarColor;

  Color get titleColor => isDark ? _AppColors._darkTitleColor : _AppColors._lightTitleColor;

  Color get buttonBg1Color => isDark ? _AppColors._darkButtonBg1Color : _AppColors._lightButtonBg1Color;

  Color get buttonText1Color => isDark ? _AppColors._darkButtonText1Color : _AppColors._lightButtonText1Color;

  Color get buttonBg2Color => isDark ? _AppColors._darkButtonBg2Color : _AppColors._lightButtonBg2Color;

  Color get buttonText2Color => isDark ? _AppColors._darkButtonText2Color : _AppColors._lightButtonText2Color;

  Color get searchColor => isDark ? _AppColors._darkSearchColor : _AppColors._lightSearchColor;
}
