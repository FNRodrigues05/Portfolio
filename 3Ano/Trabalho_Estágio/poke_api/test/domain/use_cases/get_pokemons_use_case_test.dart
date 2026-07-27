import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/get_pokemons_use_case.dart';

class FakePokemonRepository implements PokemonRepository {
  bool shouldFail = false;
  List<Pokemon> fakeList = [];

  @override
  Future<Either<AppError, List<Pokemon>>> getPokemons(int offset) async {
    if (shouldFail) {
      return Left(AppError('Erro ao carregar Pokémons'));
    }
    return Right(fakeList);
  }

  @override
  Future<Either<AppError, Pokemon>> getPokemonDetails(int id) async {
    return Right(Pokemon(id: 1, name: 'bulbasaur', imageUrl: ''));
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
  Future<Either<AppError, bool>> toggleFavorite(int id) async {
    return Right(true);
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getEvolutionChain(int id) {
    throw UnimplementedError();
  }
}

void main() {
  late GetPokemonsUseCase useCase;
  late FakePokemonRepository fakeRepository;

  setUp(() {
    fakeRepository = FakePokemonRepository();
    useCase = GetPokemonsUseCase(fakeRepository);
  });

  const tPokemonId = 1;

  test(
    'Deve retornar true quando adicionar aos favoritos com sucesso',
    () async {
      fakeRepository.shouldFail = false;
      fakeRepository.fakeList = [
        Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url'),
      ];

      final result = await useCase(tPokemonId);

      expect(result.fold((l) => null, (r) => r), fakeRepository.fakeList);
    },
  );

  test('Deve Retornar uma lista vazia se não houver mais resultados', () async {
    fakeRepository.shouldFail = false;
    fakeRepository.fakeList = [];

    final result = await useCase(tPokemonId);
    expect(result.fold((l) => null, (r) => r), []);
  });

  test('Deve retornar um AppError quando o repositório falhar', () async {
    fakeRepository.shouldFail = true;

    final result = await useCase(tPokemonId);

    expect(
      result.fold((l) => l.errorMsg, (r) => ''),
      'Erro ao carregar Pokémons',
    );
  });
}
