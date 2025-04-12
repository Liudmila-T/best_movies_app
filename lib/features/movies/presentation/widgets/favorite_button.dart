import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/assets.dart';

class FavoriteButton extends StatelessWidget {
  final Color? color;
  final VoidCallback onTap;

  const FavoriteButton({super.key, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: SvgPicture.asset(Assets.star, color: color));
  }
}
