import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/check_if_favorite_use_case.dart';

class FakePokemonRepository implements PokemonRepository {
  bool shouldFail = false;
  bool isFav = true;

  @override
  Future<Either<AppError, bool>> isFavorite(int id) async {
    if (shouldFail) {
      return Left(AppError('Erro ao verificar favorito'));
    }
    return Right(isFav);
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
  Future<Either<AppError, bool>> toggleFavorite(int id) async {
    return Right(true);
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
  late CheckIfFavoriteUseCase useCase;
  late FakePokemonRepository fakeRepository;

  setUp(() {
    fakeRepository = FakePokemonRepository();
    useCase = CheckIfFavoriteUseCase(fakeRepository);
  });

  const tPokemonId = 1;

  test('Deve retornar true quando o Pokémon for favorito', () async {
    fakeRepository.shouldFail = false;
    fakeRepository.isFav = true;

    final result = await useCase(tPokemonId);

    expect(result, Right(true));
  });

  test('Deve retornar false quando o Pokémon não for favorito', () async {
    fakeRepository.shouldFail = false;
    fakeRepository.isFav = false;

    final result = await useCase(tPokemonId);

    expect(result, Right(false));
  });

  test('Deve retornar AppError quando o repositório falhar', () async {
    fakeRepository.shouldFail = true;

    final result = await useCase(tPokemonId);

    expect(
      result.fold((l) => l.errorMsg, (r) => ''),
      'Erro ao verificar favorito',
    );
  });
}
