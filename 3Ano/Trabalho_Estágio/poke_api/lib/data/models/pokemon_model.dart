import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    super.types,
    super.stats,
    super.height,
    super.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('url')) {
      final url = json['url'] as String;
      final id = int.parse(url.split('/').reversed.elementAt(1));
      return PokemonModel(
        id: id,
        name: json['name'],
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      );
    }

    final typesList = (json['types'] as List?)?.map((t) {
      return t is Map ? t['type']['name'] as String : t.toString();
    }).toList();

    final statsMap = <String, int>{};
    if (json['stats'] != null) {
      if (json['stats'] is List) {
        for (var s in (json['stats'] as List)) {
          statsMap[s['stat']['name']] = s['base_stat'];
        }
      } else {
        (json['stats'] as Map).forEach((k, v) {
          statsMap[k.toString()] = v as int;
        });
      }
    }

    String finalImageUrl = json['imageUrl'] ?? '';
    if (finalImageUrl.isEmpty && json['sprites'] != null) {
      finalImageUrl =
          json['sprites']?['other']?['official-artwork']?['front_default'] ??
          '';
    }

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: finalImageUrl,
      types: typesList,
      stats: statsMap,
      height: json['height'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'types': types,
    'stats': stats,
    'height': height,
    'weight': weight,
  };
}
