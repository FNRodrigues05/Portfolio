import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/toggle_favorite_use_case.dart';

class FakePokemonRepository implements PokemonRepository {
  bool shouldFail = false;
  bool toggleResult = true;

  @override
  Future<Either<AppError, bool>> toggleFavorite(int id) async {
    if (shouldFail) {
      return Left(AppError('Erro ao alterar Favorito'));
    }
    return Right(toggleResult);
  }

  @override
  Future<Either<AppError, Pokemon>> getPokemonDetails(int id) async {
    return Right(Pokemon(id: 1, name: 'bulbasaur', imageUrl: ''));
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getPokemons(int offset) async {
    return Right([]);
  }

  @override
  Future<Either<AppError, bool>> isFavorite(int id) async {
    return Right(false);
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getFavoritePokemons() async {
    return Right([]);
  }

  @override
  Future<Either<AppError, List<String>>> getPokemonsTypes(String type) async {
    return Right([]);
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getEvolutionChain(int id) {
    throw UnimplementedError();
  }
}

void main() {
  late ToggleFavoriteUseCase useCase;
  late FakePokemonRepository fakeRepository;

  setUp(() {
    fakeRepository = FakePokemonRepository();
    useCase = ToggleFavoriteUseCase(fakeRepository);
  });

  const tPokemonId = 1;

  test(
    'Deve retornar true quando adicionar aos favoritos com sucesso',
    () async {
      fakeRepository.shouldFail = false;
      fakeRepository.toggleResult = true;

      final result = await useCase(tPokemonId);

      expect(result, Right(true));
    },
  );

  test(
    'Deve Retornar false quando remover dos favoritos com sucesso',
    () async {
      fakeRepository.shouldFail = false;
      fakeRepository.toggleResult = false;

      final result = await useCase(tPokemonId);
      expect(result, Right(false));
    },
  );

  test('Deve retornar um AppError quando o repositório falhar', () async {
    fakeRepository.shouldFail = true;

    final result = await useCase(tPokemonId);

    expect(
      result.fold((l) => l.errorMsg, (r) => ''),
      'Erro ao alterar Favorito',
    );
  });
}
