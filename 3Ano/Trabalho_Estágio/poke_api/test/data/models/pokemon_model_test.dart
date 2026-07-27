import 'package:flutter_test/flutter_test.dart';
import 'package:poke_api/data/models/pokemon_model.dart';
import 'package:poke_api/domain/entities/pokemon.dart';

void main() {
  const tPokemonModel = PokemonModel(
    id: 1,
    name: 'bulbasaur',
    imageUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  );

  test('Deve ser uma subclasse da entidade Pokemon', () async {
    expect(tPokemonModel, isA<Pokemon>());
  });

  group('fromJson', () {
    test(
      'Deve retornar um modelo válido quando o JSON vem da lista (com URL)',
      () async {
        final Map<String, dynamic> jsonMap = {
          "name": "bulbasaur",
          "url": "https://pokeapi.co/api/v2/pokemon/1/",
        };

        final result = PokemonModel.fromJson(jsonMap);

        expect(result, tPokemonModel);
      },
    );

    test(
      'Deve retornar um modelo válido com stats e types quando o JSON vem dos detalhes',
      () async {
        final Map<String, dynamic> jsonMap = {
          "id": 1,
          "name": "bulbasaur",
          "sprites": {
            "other": {
              "official-artwork": {
                "front_default":
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
              },
            },
          },
          "height": 7,
          "weight": 69,
          "types": [
            {
              "type": {"name": "grass"},
            },
            {
              "type": {"name": "poison"},
            },
          ],
          "stats": [
            {
              "base_stat": 45,
              "stat": {"name": "hp"},
            },
          ],
        };

        final result = PokemonModel.fromJson(jsonMap);

        expect(result.id, 1);
        expect(result.name, 'bulbasaur');
        expect(result.types, ['grass', 'poison']);
        expect(result.stats, {'hp': 45});
        expect(result.height, 7);
        expect(result.weight, 69);
      },
    );
  });

  group('toJson', () {
    test(
      'Deve retornar um Map (JSON) com a data correta para guardar na cache',
      () async {
        const modelToCache = PokemonModel(
          id: 1,
          name: 'bulbasaur',
          imageUrl: 'url',
          types: ['grass', 'poison'],
          stats: {'hp': 45},
          height: 7,
          weight: 69,
        );

        final result = modelToCache.toJson();

        final expectedMap = {
          'id': 1,
          'name': 'bulbasaur',
          'imageUrl': 'url',
          'types': ['grass', 'poison'],
          'stats': {'hp': 45},
          'height': 7,
          'weight': 69,
        };

        expect(result, expectedMap);
      },
    );
  });
}
