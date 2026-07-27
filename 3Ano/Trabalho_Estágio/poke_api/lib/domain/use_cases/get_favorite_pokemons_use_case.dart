import 'package:fpdart/fpdart.dart';

import '../entities/pokemon.dart';
import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

abstract class GetFavoritePokemonsUseCase {
  factory GetFavoritePokemonsUseCase(PokemonRepository repository) =
      _GetFavoritePokemonsUseCase;

  Future<Either<AppError, List<Pokemon>>> call();
}

class _GetFavoritePokemonsUseCase implements GetFavoritePokemonsUseCase {
  final PokemonRepository repository;

  _GetFavoritePokemonsUseCase(this.repository);

  @override
  Future<Either<AppError, List<Pokemon>>> call() {
    return repository.getFavoritePokemons();
  }
}
