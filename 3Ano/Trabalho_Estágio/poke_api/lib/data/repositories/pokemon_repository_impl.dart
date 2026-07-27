import 'package:fpdart/fpdart.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/errors/app_error.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';
import '../models/pokemon_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;

  PokemonRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<AppError, List<Pokemon>>> getPokemons(int offset) async {
    try {
      final remotePokemons = await remoteDataSource.getPokemons(offset);

      if (offset == 0) {
        await localDataSource.cachePokemonList(remotePokemons);
      } else {
        final cached = await localDataSource.getCachedPokemonList();
        cached.addAll(remotePokemons);
        await localDataSource.cachePokemonList(cached);
      }

      return Right(remotePokemons);
    } catch (e) {
      try {
        final cached = await localDataSource.getCachedPokemonList();
        if (cached.isNotEmpty) {
          if (offset == 0) return Right(cached);
          return Left(AppError('Sem Internet para carregar mais'));
        } else {
          return Left(AppError("Pokémons não foram guardados"));
        }
      } catch (_) {
        return Left(AppError('Erro ao ler cache'));
      }
    }
  }

  @override
  Future<Either<AppError, Pokemon>> getPokemonDetails(int id) async {
    try {
      final pokemonModel = await remoteDataSource.getPokemonDetails(id);

      await localDataSource.cachePokemonDetails(pokemonModel);

      return Right(pokemonModel);
    } catch (e) {
      try {
        final cached = await localDataSource.getCachedPokemonDetails(id);
        if (cached != null) {
          return Right(cached);
        } else {
          return Left(AppError("Detalhes não foram guardados"));
        }
      } catch (_) {
        return Left(AppError("Erro ao ler cache"));
      }
    }
  }

  @override
  Future<Either<AppError, List<String>>> getPokemonsTypes(String type) async {
    try {
      final pokemonList = await remoteDataSource.getPokemonsTypes(type);
      return Right(pokemonList);
    } catch (e) {
      return Left(AppError("Erro ao ler"));
    }
  }

  @override
  Future<Either<AppError, bool>> toggleFavorite(int id) async {
    try {
      await localDataSource.toggleFavorite(id);
      final favs = localDataSource.getFavorites();
      final isNowFavorite = favs.contains(id.toString());
      return Right(isNowFavorite);
    } catch (e) {
      return Left(AppError("Erro nos Favoritos: ${e.toString()}"));
    }
  }

  @override
  Future<Either<AppError, bool>> isFavorite(int id) async {
    try {
      final favs = localDataSource.getFavorites();
      return Right(favs.contains(id.toString()));
    } catch (e) {
      return Left(AppError("Erro ao verificar Favoritos: ${e.toString()}"));
    }
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getFavoritePokemons() async {
    try {
      final favs = localDataSource.getFavorites();

      if (favs.isEmpty) {
        return Right([]);
      }
      try {
        final List<Future<Pokemon>> futures = favs.map((idString) {
          final id = int.parse(idString);
          return remoteDataSource.getPokemonDetails(id);
        }).toList();
        final pokemonList = await Future.wait(futures);

        for (var p in pokemonList) {
          await localDataSource.cachePokemonDetails(p as PokemonModel);
        }

        return Right(pokemonList);
      } catch (e) {
        List<Pokemon> offlineFavorites = [];
        for (var idStr in favs) {
          final cached = await localDataSource.getCachedPokemonDetails(
            int.parse(idStr),
          );
          if (cached != null) {
            offlineFavorites.add(cached);
          }
        }
        return Right(offlineFavorites);
      }
    } catch (e) {
      return Left(AppError("Erro ao ler Favoritos: ${e.toString()}"));
    }
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getEvolutionChain(int id) async {
    try {
      final models = await remoteDataSource.getEvolutionChain(id);
      final pokemons = models
          .map((m) => Pokemon(id: m.id, name: m.name, imageUrl: m.imageUrl))
          .toList();
      return Right(pokemons);
    } catch (e) {
      return Left(AppError('Erro ao carregar a evolução'));
    }
  }
}
