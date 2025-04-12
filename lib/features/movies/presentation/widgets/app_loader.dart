import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const AppLoader({super.key, this.size = 48, this.strokeWidth = 6});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }
}
