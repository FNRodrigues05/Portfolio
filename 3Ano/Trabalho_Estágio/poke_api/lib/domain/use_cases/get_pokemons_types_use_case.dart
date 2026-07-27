import 'package:fpdart/fpdart.dart';

import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

abstract class GetPokemonsTypesUseCase {
  factory GetPokemonsTypesUseCase(PokemonRepository repository) =
      _GetPokemonsTypesUseCase;

  Future<Either<AppError, List<String>>> call(String type);
}

class _GetPokemonsTypesUseCase implements GetPokemonsTypesUseCase {
  final PokemonRepository repository;

  _GetPokemonsTypesUseCase(this.repository);

  @override
  Future<Either<AppError, List<String>>> call(String type) async {
    return await repository.getPokemonsTypes(type);
  }
}
