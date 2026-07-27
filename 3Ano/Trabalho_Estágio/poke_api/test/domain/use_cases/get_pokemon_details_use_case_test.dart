import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/get_pokemon_details_use_case.dart';

class FakePokemonRepository implements PokemonRepository {
  bool shouldFail = false;

  final fakePokemon = const Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url');

  @override
  Future<Either<AppError, Pokemon>> getPokemonDetails(int id) async {
    if (shouldFail) {
      return Left(AppError('Sem Internet'));
    }
    return Right(fakePokemon);
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
  late GetPokemonDetailsUseCase useCase;
  late FakePokemonRepository fakeRepository;

  setUp(() {
    fakeRepository = FakePokemonRepository();
    useCase = GetPokemonDetailsUseCase(fakeRepository);
  });

  const tPokemonId = 1;

  test(
    'Deve retornar um Pokemon quando o repositório for bem sucedido',
    () async {
      fakeRepository.shouldFail = false;

      final result = await useCase(tPokemonId);

      expect(result, Right(fakeRepository.fakePokemon));
    },
  );

  test('Deve Retornar um AppError quando o repositório falhar', () async {
    fakeRepository.shouldFail = true;

    final result = await useCase(tPokemonId);
    expect(result.fold((l) => l.errorMsg, (r) => ''), 'Sem Internet');
  });
}
