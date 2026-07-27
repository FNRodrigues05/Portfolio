import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/get_favorite_pokemons_use_case.dart';

class FakePokemonRepository implements PokemonRepository {
  bool shouldFail = false;
  List<Pokemon> fakeFavoritesList = [];

  @override
  Future<Either<AppError, List<Pokemon>>> getFavoritePokemons() async {
    if (shouldFail) {
      return Left(AppError('Erro ao carregar Favoritos'));
    } else {
      return Right(fakeFavoritesList);
    }
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
  Future<Either<AppError, bool>> toggleFavorite(int id) async {
    return Right(true);
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
  late GetFavoritePokemonsUseCase useCase;
  late FakePokemonRepository fakeRepository;

  setUp(() {
    fakeRepository = FakePokemonRepository();
    useCase = GetFavoritePokemonsUseCase(fakeRepository);
  });

  test('Deve retornar uma lista de Pokemons favoritos com sucesso', () async {
    fakeRepository.shouldFail = false;
    fakeRepository.fakeFavoritesList = [
      const Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url'),
    ];

    final result = await useCase();
    expect(
      result.fold((l) => null, (r) => r),
      fakeRepository.fakeFavoritesList,
    );
  });

  test(
    'Deve retornar uma lista vazia de pokemons quando nao ha favoritos',
    () async {
      fakeRepository.shouldFail = true;
      fakeRepository.fakeFavoritesList = [];

      final result = await useCase();

      expect(result.fold((l) => null, (r) => r), null);
    },
  );

  test('Deve retornar um AppError quando o repositório falhar', () async {
    fakeRepository.shouldFail = true;

    final result = await useCase();

    expect(
      result.fold((l) => l.errorMsg, (r) => ''),
      'Erro ao carregar Favoritos',
    );
  });
}
