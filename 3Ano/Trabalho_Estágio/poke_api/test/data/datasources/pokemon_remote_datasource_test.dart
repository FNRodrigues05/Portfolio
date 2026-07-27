import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:poke_api/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_api/data/models/pokemon_model.dart';

void main() {
  group('PokemonRemoteDataSource', () {
    test(
      'getPokemons - Deve retornar lista de modelos quando o código for 200 (Sucesso)',
      () async {
        final mockClient = MockClient((request) async {
          const jsonResponse =
              '{"results": [{"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"}]}';
          return http.Response(jsonResponse, 200);
        });
        final dataSource = PokemonRemoteDataSource(client: mockClient);

        final result = await dataSource.getPokemons(0);

        expect(result, isA<List<PokemonModel>>());
        expect(result.first.name, 'bulbasaur');
        expect(result.first.id, 1);
      },
    );

    test(
      'getPokemons - Deve atirar uma Exception quando o código não for 200',
      () async {
        final mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });

        final dataSource = PokemonRemoteDataSource(client: mockClient);

        expect(() => dataSource.getPokemons(0), throwsException);
      },
    );

    test(
      'getPokemonDetails - Deve retornar o PokemonModel detalhado quando o código for 200 (Sucesso)',
      () async {
        final mockClient = MockClient((request) async {
          // AQUI ESTAVA O ERRO! Adicionámos a estrutura dos sprites ao JSON falso.
          const jsonResponse =
              '{"id": 1, "name": "bulbasaur", "height": 7, "weight": 69, "sprites": {"other": {"official-artwork": {"front_default": "url"}}}}';
          return http.Response(jsonResponse, 200);
        });
        final dataSource = PokemonRemoteDataSource(client: mockClient);

        final result = await dataSource.getPokemonDetails(1);

        expect(result.name, 'bulbasaur');
        expect(result.height, 7);
        expect(result.weight, 69);
      },
    );

    test(
      'getPokemonDetails - Deve atirar uma Exception quando a API falhar',
      () async {
        final mockClient = MockClient((request) async {
          return http.Response('Internal Server Error', 500);
        });
        final dataSource = PokemonRemoteDataSource(client: mockClient);

        expect(() => dataSource.getPokemonDetails(1), throwsException);
      },
    );

    test(
      'getPokemonsTypes - Deve retornar uma lista de nomees de Pokemons quando o código for 200 (Sucesso)',
      () async {
        final mockClient = MockClient((request) async {
          const jsonResponse =
              '{"pokemon": [{"pokemon": {"name": "charmander"}}]}';
          return http.Response(jsonResponse, 200);
        });

        final dataSource = PokemonRemoteDataSource(client: mockClient);

        final result = await dataSource.getPokemonsTypes('fire');

        expect(result, isA<List<String>>());
        expect(result.first, 'charmander');
      },
    );

    test(
      'getPokemonTypes - Deve retornar lista vazia se der erro na API',
      () async {
        final mockClient = MockClient((request) async {
          return http.Response('Not Found', 404);
        });
        final dataSource = PokemonRemoteDataSource(client: mockClient);

        final result = await dataSource.getPokemonsTypes('fire');

        expect(result, isEmpty);
      },
    );
  });
}
