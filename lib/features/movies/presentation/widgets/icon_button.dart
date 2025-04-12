import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({super.key, required this.icon, required this.onTap});
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: SvgPicture.asset(icon, color: context.textColor, width: 24, height: 24), onPressed: onTap);
  }
}
