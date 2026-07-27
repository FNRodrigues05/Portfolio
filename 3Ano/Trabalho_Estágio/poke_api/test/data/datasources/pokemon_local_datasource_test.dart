import 'package:flutter_test/flutter_test.dart';
import 'package:poke_api/data/datasources/pokemon_local_datasource.dart';
import 'package:poke_api/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late PokemonLocalDataSource dataSource;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});

    prefs = await SharedPreferences.getInstance();

    dataSource = PokemonLocalDataSource(prefs: prefs);
  });

  group('PokemonLocalDataSource - Favoritos', () {
    test('getFavorites - Deve retornar lista vazia inicialmente', () {
      final result = dataSource.getFavorites();
      expect(result, isEmpty);
    });

    test(
      'toggleFavorite - Deve adicionar um ID aos favoritos se ele não existir',
      () async {
        await dataSource.toggleFavorite(1);
        await dataSource.toggleFavorite(4);

        final result = dataSource.getFavorites();
        expect(result, ['1', '4']);
      },
    );

    test(
      'toggleFavorite - Deve remover um ID dos favoritos se ele já existir',
      () async {
        prefs.setStringList(PokemonLocalDataSource.favKey, ['1', '4']);

        await dataSource.toggleFavorite(1);

        final result = dataSource.getFavorites();
        expect(result, ['4']);
      },
    );

    test(
      'toggleFavorite - Deve remover a chave da base de dados se a lista ficar vazia',
      () async {
        prefs.setStringList(PokemonLocalDataSource.favKey, ['1']);

        await dataSource.toggleFavorite(1);

        expect(prefs.containsKey(PokemonLocalDataSource.favKey), isFalse);
      },
    );
  });

  group('PokemonLocalDataSource - Cache da Lista', () {
    final tPokemonList = [
      const PokemonModel(id: 1, name: 'bulbasaur', imageUrl: 'url'),
    ];

    test(
      'getCachedPokemonList - Deve retornar lista vazia se não houver cache',
      () async {
        final result = await dataSource.getCachedPokemonList();
        expect(result, isEmpty);
      },
    );

    test(
      'cachePokemonList & getCachedPokemonList - Deve guardar e recuperar a lista de Pokémons',
      () async {
        await dataSource.cachePokemonList(tPokemonList);

        final result = await dataSource.getCachedPokemonList();

        expect(result.length, 1);
        expect(result.first.name, 'bulbasaur');
      },
    );
  });

  group('PokemonLocalDataSource - Cache de Datalhes', () {
    const tPokemonModel = PokemonModel(
      id: 1,
      name: 'bulbasaur',
      imageUrl: 'url',
      height: 7,
    );

    test(
      'getCachedPokemonDetails - Deve retornar null se o Pokemon não estiver na cache',
      () async {
        final result = await dataSource.getCachedPokemonDetails(1);
        expect(result, isNull);
      },
    );

    test(
      'cachePokemonDetails & getCachedPokemonDetails - Deve guardar e recuperar os detalhes',
      () async {
        await dataSource.cachePokemonDetails(tPokemonModel);

        final result = await dataSource.getCachedPokemonDetails(1);

        expect(result, isNotNull);
        expect(result!.name, 'bulbasaur');
        expect(result.height, 7);
      },
    );
  });
}
