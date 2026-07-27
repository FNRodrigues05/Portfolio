import 'package:fpdart/fpdart.dart';

import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

abstract class CheckIfFavoriteUseCase {
  factory CheckIfFavoriteUseCase(PokemonRepository repository) =
      _CheckIfFavoriteUseCase;

  Future<Either<AppError, bool>> call(int id);
}

class _CheckIfFavoriteUseCase implements CheckIfFavoriteUseCase {
  final PokemonRepository repository;

  _CheckIfFavoriteUseCase(this.repository);

  @override
  Future<Either<AppError, bool>> call(int id) async {
    return await repository.isFavorite(id);
  }
}
