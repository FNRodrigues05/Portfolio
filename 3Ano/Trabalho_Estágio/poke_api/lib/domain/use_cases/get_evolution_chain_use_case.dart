import 'package:fpdart/fpdart.dart';

import '../entities/pokemon.dart';
import '../errors/app_error.dart';
import '../repositories/pokemon_repository.dart';

class GetEvolutionChainUseCase {
  final PokemonRepository repository;

  GetEvolutionChainUseCase(this.repository);

  Future<Either<AppError, List<Pokemon>>> call(int id) async {
    return await repository.getEvolutionChain(id);
  }
}
