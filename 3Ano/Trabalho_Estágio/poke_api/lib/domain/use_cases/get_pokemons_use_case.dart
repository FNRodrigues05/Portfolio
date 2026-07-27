import 'package:fpdart/fpdart.dart';

import '../entities/pokemon.dart';
import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

abstract class GetPokemonsUseCase {
  factory GetPokemonsUseCase(PokemonRepository repository) =
      _GetPokemonsUseCase;

  Future<Either<AppError, List<Pokemon>>> call(int offset);
}

class _GetPokemonsUseCase implements GetPokemonsUseCase {
  final PokemonRepository repository;

  _GetPokemonsUseCase(this.repository);

  @override
  Future<Either<AppError, List<Pokemon>>> call(int offset) async {
    return await repository.getPokemons(offset);
  }
}
