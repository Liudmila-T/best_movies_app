import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/movie.dart';
import '../../movies_injection.dart';

final movieDetailsProvider = FutureProvider.family<Movie, int>((ref, id) async {
  final useCase = ref.watch(getMovieByIdProvider);
  final result = await useCase(id);

  return result.fold((failure) => throw Exception(failure.message), (movie) => movie);
});
