part of 'pokemon_bloc.dart';

enum PokemonStatus { initial, loading, loaded, error, empty }

extension PokemonStatusX on PokemonStatus {
  bool get isInitial => this == PokemonStatus.initial;

  bool get isLoading => this == PokemonStatus.loading;

  bool get isLoaded => this == PokemonStatus.loaded;

  bool get isError => this == PokemonStatus.error;

  bool get isEmpty => this == PokemonStatus.empty;
}

class PokemonState extends Equatable {
  const PokemonState({
    this.status = PokemonStatus.initial,
    this.pokemons = const [],
    this.favoriteIds = const [],
    this.isSearching = false,
    this.errorMessage = '',
    this.searchQuery = '',
    this.selectedType = 'Todos',
    this.pokemonsOfSelectedType,
  });

  final PokemonStatus status;
  final List<Pokemon> pokemons;
  final List<String> favoriteIds;
  final bool isSearching;
  final String errorMessage;
  final String searchQuery;
  final String selectedType;
  final List<String>? pokemonsOfSelectedType;

  List<Pokemon> get filteredPokemons {
    var result = pokemons;

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      result = result.where((pokemon) {
        final matchesName = pokemon.name.toLowerCase().contains(query);
        final matchesId = pokemon.id.toString().contains(query);
        return matchesName || matchesId;
      }).toList();
    }

    if (selectedType != 'Todos' && pokemonsOfSelectedType != null) {
      result = result.where((pokemon) {
        return pokemonsOfSelectedType!.contains(pokemon.name.toLowerCase());
      }).toList();
    }
    return result;
  }

  PokemonState copyWith({
    PokemonStatus? status,
    List<Pokemon>? pokemons,
    List<String>? favoriteIds,
    bool? isSearching,
    String? errorMessage,
    String? searchQuery,
    String? selectedType,
    List<String>? pokemonsOfSelectedType,
  }) {
    var result = PokemonState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      selectedType: selectedType ?? this.selectedType,
      pokemonsOfSelectedType:
          pokemonsOfSelectedType ?? this.pokemonsOfSelectedType,
    );
    return result;
  }

  @override
  List<Object> get props => [
    status,
    pokemons,
    errorMessage,
    searchQuery,
    isSearching,
    favoriteIds,
    selectedType,
    ?pokemonsOfSelectedType,
  ];
}
