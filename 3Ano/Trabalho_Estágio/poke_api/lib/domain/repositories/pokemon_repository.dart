import 'package:fpdart/fpdart.dart';

import '../entities/pokemon.dart';
import '../errors/app_error.dart';

abstract class PokemonRepository {
  Future<Either<AppError, List<Pokemon>>> getPokemons(int offset);

  Future<Either<AppError, Pokemon>> getPokemonDetails(int id);

  Future<Either<AppError, bool>> isFavorite(int id);

  Future<Either<AppError, bool>> toggleFavorite(int id);

  Future<Either<AppError, List<Pokemon>>> getFavoritePokemons();

  Future<Either<AppError, List<String>>> getPokemonsTypes(String type);

  Future<Either<AppError, List<Pokemon>>> getEvolutionChain(int id);
}
