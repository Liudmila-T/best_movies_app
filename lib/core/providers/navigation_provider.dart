import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return createRouter();
});

final navigationProvider = Provider<NavigationService>((ref) {
  final goRouter = ref.read(goRouterProvider);
  return NavigationService(goRouter);
});
