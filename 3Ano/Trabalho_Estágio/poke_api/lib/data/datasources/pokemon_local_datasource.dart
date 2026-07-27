import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/pokemon_model.dart';

class PokemonLocalDataSource {
  final SharedPreferences prefs;
  static const String favKey = 'FAVORITES_KEY';
  static const String pokemonCacheKey = 'POKEMON_CACHE_KEY';

  PokemonLocalDataSource({required this.prefs});

  Future<void> toggleFavorite(int id) async {
    List<String> favs = prefs.getStringList(favKey) ?? [];
    String idStr = id.toString();

    if (favs.contains(idStr)) {
      favs.remove(idStr);
    } else {
      favs.add(idStr);
    }

    if (favs.isEmpty) {
      await prefs.remove(favKey);
    } else {
      favs.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      await prefs.setStringList(favKey, favs);
    }
  }

  List<String> getFavorites() => prefs.getStringList(favKey) ?? [];

  Future<void> cachePokemonList(List<PokemonModel> pokemons) async {
    final String json = jsonEncode(pokemons.map((e) => e.toJson()).toList());
    await prefs.setString(pokemonCacheKey, json);
  }

  Future<List<PokemonModel>> getCachedPokemonList() async {
    final json = prefs.getString(pokemonCacheKey);
    if (json != null) {
      final List<dynamic> jsonList = jsonDecode(json);
      return jsonList.map((json) => PokemonModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> cachePokemonDetails(PokemonModel pokemon) async {
    final String json = jsonEncode(pokemon.toJson());
    await prefs.setString('POKEMON_CACHE_KEY_${pokemon.id}', json);
  }

  Future<PokemonModel?> getCachedPokemonDetails(int id) async {
    final json = prefs.getString('POKEMON_CACHE_KEY_$id');
    if (json != null) {
      return PokemonModel.fromJson(jsonDecode(json));
    }
    return null;
  }
}
