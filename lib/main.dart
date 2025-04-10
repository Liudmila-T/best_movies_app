import 'package:best_movies_app/core/theme/app_colors.dart';
import 'package:best_movies_app/core/theme/app_text_styles.dart';
import 'package:best_movies_app/core/theme/theme_mode_provider.dart';
import 'package:best_movies_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);
    final GoRouter router = createRouter();
    return MaterialApp.router(
      title: 'Best Movies App',
      theme: ThemeData(
        primaryColor: isDarkMode ? AppColors.darkPrimaryColor : AppColors.lightPrimaryColor,
        scaffoldBackgroundColor: isDarkMode ? AppColors.darkSecondaryColor : AppColors.lightSecondaryColor,
        textTheme: TextTheme(displayLarge: AppTextStyles.displayLarge, bodyLarge: AppTextStyles.bodyLarge),
      ),
      darkTheme: ThemeData(
        primaryColor: AppColors.darkPrimaryColor,
        scaffoldBackgroundColor: AppColors.darkSecondaryColor,
        textTheme: TextTheme(displayLarge: AppTextStyles.displayLarge, bodyLarge: AppTextStyles.bodyLarge),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}
