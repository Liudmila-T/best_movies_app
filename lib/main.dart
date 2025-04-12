import 'package:best_movies_app/core/theme/theme_mode_provider.dart';
import 'package:best_movies_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    _checkAndSetTheme(ref, context, themeMode);

    final GoRouter router = createRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }

  void _checkAndSetTheme(WidgetRef ref, BuildContext context, ThemeMode themeMode) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (themeMode == ThemeMode.system) {
        final brightness = MediaQuery.of(context).platformBrightness;
        if (brightness == Brightness.dark) {
          ref.read(themeModeProvider.notifier).setTheme(ThemeMode.dark);
        } else {
          ref.read(themeModeProvider.notifier).setTheme(ThemeMode.light);
        }
      }
    });
  }
}
