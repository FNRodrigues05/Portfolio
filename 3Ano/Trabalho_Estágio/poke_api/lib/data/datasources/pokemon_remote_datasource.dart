import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

class PokemonRemoteDataSource {
  final http.Client client;
  final String baseUrl = "https://pokeapi.co/api/v2";

  PokemonRemoteDataSource({required this.client});

  Future<List<PokemonModel>> getPokemons(int offset) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=2000'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      return results.map((e) => PokemonModel.fromJson(e)).toList();
    } else {
      throw Exception('Falha ao carregar Pokémons');
    }
  }

  Future<PokemonModel> getPokemonDetails(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/pokemon/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PokemonModel.fromJson(data);
    } else {
      throw Exception('Falha ao carregar detalhes do pokémon');
    }
  }

  Future<List<String>> getPokemonsTypes(String type) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/type/${type.toLowerCase()}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final pokemonArray = data['pokemon'] as List;
        return pokemonArray
            .map((pokemon) => pokemon['pokemon']['name'] as String)
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<PokemonModel>> getEvolutionChain(int pokemonId) async {
    try {
      final speciesResponse = await client.get(
        Uri.parse('$baseUrl/pokemon-species/$pokemonId'),
      );

      if (speciesResponse.statusCode == 200) {
        final speciesData = jsonDecode(speciesResponse.body);
        final String evolutionUrl = speciesData['evolution_chain']['url'];

        final evoResponse = await client.get(Uri.parse(evolutionUrl));

        if (evoResponse.statusCode == 200) {
          final evoData = jsonDecode(evoResponse.body);
          List<PokemonModel> evolutions = [];

          var currentStep = evoData['chain'];

          while (currentStep != null) {
            final speciesInfo = currentStep['species'];
            final name = speciesInfo['name'] as String;
            final url = speciesInfo['url'] as String;

            final urlParts = url.split('/');
            final id = int.parse(urlParts[urlParts.length - 2]);

            final imageUrl =
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

            evolutions.add(
              PokemonModel(id: id, name: name, imageUrl: imageUrl),
            );

            if (currentStep['evolves_to'] != null &&
                currentStep['evolves_to'].isNotEmpty) {
              currentStep = currentStep['evolves_to'][0];
            } else {
              currentStep = null;
            }
          }
          return evolutions;
        }
      }
      return [];
    } catch (e) {
      throw Exception('Falha ao carregar a linha evolutiva');
    }
  }
}
