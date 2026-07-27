import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:poke_api/data/datasources/pokemon_local_datasource.dart';
import 'package:poke_api/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_api/data/models/pokemon_model.dart';
import 'package:poke_api/data/repositories/pokemon_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeRemoteDataSource implements PokemonRemoteDataSource {
  bool shouldFail = false;
  final fakePokemonModel = const PokemonModel(
    id: 1,
    name: 'bulbasaur',
    imageUrl: 'url',
  );
  final fakePokemonList = [
    const PokemonModel(id: 1, name: 'bulbasaur', imageUrl: 'url'),
  ];
  final fakeTypesList = ['bulbasaur'];

  @override
  Future<PokemonModel> getPokemonDetails(int id) async {
    if (shouldFail) throw Exception('Sem internet');
    return fakePokemonModel;
  }

  @override
  Future<List<PokemonModel>> getPokemons(int offset) async {
    if (shouldFail) throw Exception('Sem internet');
    return fakePokemonList;
  }

  @override
  Future<List<String>> getPokemonsTypes(String type) async {
    if (shouldFail) throw Exception('Sem internet');
    return fakeTypesList;
  }

  @override
  String get baseUrl => '';

  @override
  http.Client get client => throw UnimplementedError();

  @override
  Future<List<PokemonModel>> getEvolutionChain(int pokemonId) {
    throw UnimplementedError();
  }
}

class FakeLocalDataSource implements PokemonLocalDataSource {
  bool shouldFailFavorites = false;
  bool shouldFailCache = false;
  bool isEmptyCache = false;
  final fakePokemonModel = const PokemonModel(
    id: 1,
    name: 'bulbasaur_cached',
    imageUrl: 'url',
  );
  List<PokemonModel> cachedList = [];
  List<String> favoritesList = [];

  @override
  Future<void> cachePokemonDetails(PokemonModel pokemon) async {}

  @override
  Future<PokemonModel?> getCachedPokemonDetails(int id) async {
    if (shouldFailCache) throw Exception('Erro a ler base de dados');
    if (isEmptyCache) return null;
    return fakePokemonModel;
  }

  @override
  Future<void> cachePokemonList(List<PokemonModel> pokemons) async {
    cachedList = pokemons;
  }

  @override
  Future<List<PokemonModel>> getCachedPokemonList() async {
    if (shouldFailCache) throw Exception('Erro a ler base de dados');
    if (isEmptyCache) return [];
    if (cachedList.isNotEmpty) return cachedList;
    return [fakePokemonModel];
  }

  @override
  Future<void> toggleFavorite(int id) async {
    if (shouldFailFavorites) throw Exception('Erro toggle');
    final idStr = id.toString();
    if (favoritesList.contains(idStr)) {
      favoritesList.remove(idStr);
    } else {
      favoritesList.add(idStr);
    }
  }

  @override
  List<String> getFavorites() {
    if (shouldFailFavorites) throw Exception('Erro favs');
    return favoritesList;
  }

  @override
  SharedPreferences get prefs => throw UnimplementedError();
}

void main() {
  late PokemonRepositoryImpl repository;
  late FakeRemoteDataSource fakeRemote;
  late FakeLocalDataSource fakeLocal;

  setUp(() {
    fakeRemote = FakeRemoteDataSource();
    fakeLocal = FakeLocalDataSource();
    repository = PokemonRepositoryImpl(fakeRemote, fakeLocal);
  });

  const tPokemonId = 1;

  group('getPokemonDetails', () {
    test('Deve retornar dados remotos e guardar na cache', () async {
      final result = await repository.getPokemonDetails(tPokemonId);
      expect(result.fold((l) => null, (r) => r), fakeRemote.fakePokemonModel);
    });

    test('Deve retornar da CACHE local quando a API falha', () async {
      fakeRemote.shouldFail = true;
      final result = await repository.getPokemonDetails(tPokemonId);
      expect(result.fold((l) => null, (r) => r), fakeLocal.fakePokemonModel);
    });

    test('Deve retornar AppError quando API falha e CACHE vazia', () async {
      fakeRemote.shouldFail = true;
      fakeLocal.isEmptyCache = true;
      final result = await repository.getPokemonDetails(tPokemonId);
      expect(
        result.fold((l) => l.errorMsg, (r) => ''),
        'Detalhes não foram guardados',
      );
    });

    test('Deve retornar AppError quando ocorre erro a ler cache', () async {
      fakeRemote.shouldFail = true;
      fakeLocal.shouldFailCache = true;
      final result = await repository.getPokemonDetails(tPokemonId);
      expect(result.fold((l) => l.errorMsg, (r) => ''), 'Erro ao ler cache');
    });
  });

  group('getPokemons', () {
    test('Deve retornar lista remota no offset 0', () async {
      final result = await repository.getPokemons(0);
      expect(result.fold((l) => null, (r) => r), fakeRemote.fakePokemonList);
    });

    test(
      'Deve retornar lista remota no offset > 0 (junta com cache)',
      () async {
        fakeLocal.cachedList = [fakeLocal.fakePokemonModel];
        final result = await repository.getPokemons(20);
        expect(result.fold((l) => null, (r) => r), fakeRemote.fakePokemonList);
      },
    );

    test('Deve usar a cache se a internet falhar no offset 0', () async {
      fakeRemote.shouldFail = true;
      final result = await repository.getPokemons(0);
      expect(result.fold((l) => null, (r) => r), [fakeLocal.fakePokemonModel]);
    });

    test(
      'Deve dar erro de "Sem Internet para carregar mais" se falhar com offset > 0',
      () async {
        fakeRemote.shouldFail = true;
        final result = await repository.getPokemons(20);
        expect(
          result.fold((l) => l.errorMsg, (r) => ''),
          'Sem Internet para carregar mais',
        );
      },
    );

    test('Deve dar erro se falhar e a cache estiver vazia', () async {
      fakeRemote.shouldFail = true;
      fakeLocal.isEmptyCache = true;
      final result = await repository.getPokemons(0);
      expect(
        result.fold((l) => l.errorMsg, (r) => ''),
        'Pokémons não foram guardados',
      );
    });

    test('Deve dar erro estranho se a cache estourar no catch', () async {
      fakeRemote.shouldFail = true;
      fakeLocal.shouldFailCache = true;
      final result = await repository.getPokemons(0);
      expect(result.fold((l) => l.errorMsg, (r) => ''), 'Erro ao ler cache');
    });
  });

  group('getPokemonsTypes', () {
    test('Deve retornar lista de tipos', () async {
      final result = await repository.getPokemonsTypes('fire');
      expect(result.fold((l) => null, (r) => r), fakeRemote.fakeTypesList);
    });

    test('Deve retornar erro se falhar a ler tipos', () async {
      fakeRemote.shouldFail = true;
      final result = await repository.getPokemonsTypes('fire');
      expect(result.fold((l) => l.errorMsg, (r) => ''), 'Erro ao ler');
    });
  });

  group('Favoritos (toggle & isFavorite)', () {
    test('isFavorite - Deve retornar false se não for favorito', () async {
      final result = await repository.isFavorite(1);
      expect(result.fold((l) => null, (r) => r), false);
    });

    test('isFavorite - Deve dar erro de leitura', () async {
      fakeLocal.shouldFailFavorites = true;
      final result = await repository.isFavorite(1);
      expect(
        result.fold((l) => l.errorMsg, (r) => ''),
        contains('Erro ao verificar Favoritos'),
      );
    });

    test('toggleFavorite - Deve adicionar favorito com sucesso', () async {
      final result = await repository.toggleFavorite(1);
      expect(result.fold((l) => null, (r) => r), true);
    });

    test('toggleFavorite - Deve dar erro se base de dados falhar', () async {
      fakeLocal.shouldFailFavorites = true;
      final result = await repository.toggleFavorite(1);
      expect(
        result.fold((l) => l.errorMsg, (r) => ''),
        contains('Erro nos Favoritos'),
      );
    });
  });

  group('getFavoritePokemons', () {
    test('Deve retornar lista vazia se não houver favoritos', () async {
      final result = await repository.getFavoritePokemons();
      expect(result.fold((l) => null, (r) => r), []);
    });

    test(
      'Deve retornar favoritos completos da API e guardar na cache',
      () async {
        fakeLocal.favoritesList = ['1'];
        final result = await repository.getFavoritePokemons();
        expect(result.fold((l) => null, (r) => r), [
          fakeRemote.fakePokemonModel,
        ]);
      },
    );

    test('Deve ir buscar offline se a API falhar no meio', () async {
      fakeLocal.favoritesList = ['1'];
      fakeRemote.shouldFail = true;
      final result = await repository.getFavoritePokemons();
      expect(result.fold((l) => null, (r) => r), [fakeLocal.fakePokemonModel]);
    });

    test(
      'Deve retornar erro geral se rebentar a ler a lista inicial',
      () async {
        fakeLocal.shouldFailFavorites = true;
        final result = await repository.getFavoritePokemons();
        expect(
          result.fold((l) => l.errorMsg, (r) => ''),
          contains('Erro ao ler Favoritos'),
        );
      },
    );
  });
}
