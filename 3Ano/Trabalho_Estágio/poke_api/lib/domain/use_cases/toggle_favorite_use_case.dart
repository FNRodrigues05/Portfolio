import 'package:fpdart/fpdart.dart';

import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

abstract class ToggleFavoriteUseCase {
  factory ToggleFavoriteUseCase(PokemonRepository repository) =
      _ToggleFavoriteUseCase;

  Future<Either<AppError, bool>> call(int id);
}

class _ToggleFavoriteUseCase implements ToggleFavoriteUseCase {
  final PokemonRepository repository;

  _ToggleFavoriteUseCase(this.repository);

  @override
  Future<Either<AppError, bool>> call(int id) async {
    return await repository.toggleFavorite(id);
  }
}
