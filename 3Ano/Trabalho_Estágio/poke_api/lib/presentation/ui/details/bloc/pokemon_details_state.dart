part of 'pokemon_details_bloc.dart';

enum PokemonDetailsStatus { initial, loading, loaded, error }

extension PokemonDetailsStatusX on PokemonDetailsStatus {
  bool get isInitial => this == PokemonDetailsStatus.initial;

  bool get isLoading => this == PokemonDetailsStatus.loading;

  bool get isLoaded => this == PokemonDetailsStatus.loaded;

  bool get isError => this == PokemonDetailsStatus.error;
}

class PokemonDetailsState extends Equatable {
  final PokemonDetailsStatus status;
  final Pokemon? pokemon;
  final String? errorMessage;
  final bool isFavorite;
  final List<Pokemon> evolutionChain;
  final bool isEvolutionLoading;

  const PokemonDetailsState({
    this.status = PokemonDetailsStatus.initial,
    this.pokemon,
    this.errorMessage,
    this.isFavorite = false,
    this.evolutionChain = const [],
    this.isEvolutionLoading = false,
  });

  PokemonDetailsState copyWith({
    PokemonDetailsStatus? status,
    Pokemon? pokemon,
    String? errorMessage,
    bool? isFavorite,
    List<Pokemon>? evolutionChain,
    bool? isEvolutionLoading,
  }) {
    return PokemonDetailsState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      errorMessage: errorMessage ?? this.errorMessage,
      isFavorite: isFavorite ?? this.isFavorite,
      evolutionChain: evolutionChain ?? this.evolutionChain,
      isEvolutionLoading: isEvolutionLoading ?? this.isEvolutionLoading,
    );
  }

  @override
  List<Object?> get props => [
    status,
    pokemon,
    errorMessage,
    isFavorite,
    evolutionChain,
    isEvolutionLoading,
  ];
}
