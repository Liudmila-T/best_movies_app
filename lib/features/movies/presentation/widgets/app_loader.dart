import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: context.textColor.withAlpha(153), // opacity 0.6 (255 * 0.6 = 153)
        size: 80.0,
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }
}
