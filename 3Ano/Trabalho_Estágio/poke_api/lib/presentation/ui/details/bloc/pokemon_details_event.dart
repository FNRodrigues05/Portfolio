part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonDetailsEvent extends PokemonDetailsEvent {
  final int id;

  const FetchPokemonDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ToggleFavoriteEvent extends PokemonDetailsEvent {
  final Pokemon pokemon;

  const ToggleFavoriteEvent(this.pokemon);

  @override
  List<Object> get props => [pokemon];
}

class CheckIfFavoriteEvent extends PokemonDetailsEvent {
  final int pokemonId;

  const CheckIfFavoriteEvent(this.pokemonId);

  @override
  List<Object> get props => [pokemonId];
}

class LoadEvolutionEvent extends PokemonDetailsEvent {
  final int pokemonId;

  const LoadEvolutionEvent(this.pokemonId);

  @override
  List<Object> get props => [pokemonId];
}
