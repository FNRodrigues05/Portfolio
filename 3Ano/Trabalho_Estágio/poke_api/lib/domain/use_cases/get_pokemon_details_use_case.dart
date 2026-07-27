import 'package:fpdart/fpdart.dart';

import '../entities/pokemon.dart';
import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

abstract class GetPokemonDetailsUseCase {
  factory GetPokemonDetailsUseCase(PokemonRepository repository) =
      _GetPokemonDetailsUseCase;

  Future<Either<AppError, Pokemon>> call(int id);
}

class _GetPokemonDetailsUseCase implements GetPokemonDetailsUseCase {
  final PokemonRepository repository;

  _GetPokemonDetailsUseCase(this.repository);

  @override
  Future<Either<AppError, Pokemon>> call(int id) async {
    return await repository.getPokemonDetails(id);
  }
}
