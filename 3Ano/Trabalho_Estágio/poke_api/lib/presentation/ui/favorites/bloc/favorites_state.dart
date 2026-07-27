part of 'favorites_bloc.dart';

enum FavoritesStatus { initial, error, loading, loaded, empty }

extension FavoritesStatusX on FavoritesStatus {
  bool get isInitial => this == FavoritesStatus.initial;

  bool get isLoading => this == FavoritesStatus.loading;

  bool get isLoaded => this == FavoritesStatus.loaded;

  bool get isError => this == FavoritesStatus.error;

  bool get isEmpty => this == FavoritesStatus.empty;
}

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.pokemons = const [],
    this.errorMessage = '',
  });

  final FavoritesStatus status;
  final List<Pokemon> pokemons;
  final String errorMessage;

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Pokemon>? pokemons,
    String? errorMessage,
  }) {
    var result = FavoritesState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      errorMessage: errorMessage ?? this.errorMessage,
    );
    return result;
  }

  @override
  List<Object> get props => [status, pokemons, errorMessage];
}
