part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent extends Equatable {
  const PokemonEvent();
}

class LoadPokemonEvent extends PokemonEvent {
  const LoadPokemonEvent();

  @override
  List<Object?> get props => [];
}

class FetchPokemonEvent extends PokemonEvent {
  const FetchPokemonEvent();

  @override
  List<Object?> get props => [];
}

class SearchPokemonEvent extends PokemonEvent {
  final String query;

  const SearchPokemonEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ToggleSearchEvent extends PokemonEvent {
  const ToggleSearchEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends PokemonEvent {
  const LoadFavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FilterByTypeEvent extends PokemonEvent {
  final String type;

  const FilterByTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}
