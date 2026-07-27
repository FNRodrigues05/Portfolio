import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/get_pokemons_types_use_case.dart';

class FakePokemonRepository implements PokemonRepository {
  bool shouldFail = false;
  List<String> fakeTypes = [];

  @override
  Future<Either<AppError, List<String>>> getPokemonsTypes(String type) async {
    if (shouldFail) {
      return Left(AppError('Erro ao carregar tipos'));
    }
    return Right(fakeTypes);
  }

  @override
  Future<Either<AppError, Pokemon>> getPokemonDetails(int id) async {
    return const Right(Pokemon(id: 1, name: 'bulbasaur', imageUrl: ''));
  }

  @override
  Future<Either<AppError, List<Pokemon>>> getPokemons(int offset) async {
    return const Right([]);
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
  Future<Either<AppError, List<Pokemon>>> getEvolutionChain(int id) {
    throw UnimplementedError();
  }
}

void main() {
  late GetPokemonsTypesUseCase useCase;
  late FakePokemonRepository fakeRepository;

  setUp(() {
    fakeRepository = FakePokemonRepository();
    useCase = GetPokemonsTypesUseCase(fakeRepository);
  });

  const tType = 'fire';

  test('Deve retornar uma lista de tipos com sucesso', () async {
    fakeRepository.shouldFail = false;
    fakeRepository.fakeTypes = ['charmander', 'charmeleon', 'charizard'];

    final result = await useCase(tType);

    expect(result.fold((l) => null, (r) => r), fakeRepository.fakeTypes);
  });

  test('Deve Retornar uma lista vazia se não houver resultados', () async {
    fakeRepository.shouldFail = false;
    fakeRepository.fakeTypes = [];

    final result = await useCase(tType);

    expect(result.fold((l) => null, (r) => r), fakeRepository.fakeTypes);
  });

  test('Deve retornar um AppError quando o repositório falhar', () async {
    fakeRepository.shouldFail = true;

    final result = await useCase(tType);

    expect(result.fold((l) => l.errorMsg, (r) => ''), 'Erro ao carregar tipos');
  });
}
