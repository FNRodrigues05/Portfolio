import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_api/domain/use_cases/get_evolution_chain_use_case.dart';

import '../../../../domain/entities/pokemon.dart';
import '../../../../domain/errors/app_error.dart';
import '../../../../domain/use_cases/check_if_favorite_use_case.dart';
import '../../../../domain/use_cases/get_pokemon_details_use_case.dart';
import '../../../../domain/use_cases/toggle_favorite_use_case.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final GetPokemonDetailsUseCase _getPokemonDetailsUseCase;
  final CheckIfFavoriteUseCase _checkIfFavoriteUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetEvolutionChainUseCase _getEvolutionChainUseCase;

  PokemonDetailsBloc(
    this._getPokemonDetailsUseCase,
    this._checkIfFavoriteUseCase,
    this._toggleFavoriteUseCase,
    this._getEvolutionChainUseCase,
  ) : super(PokemonDetailsState()) {
    on<FetchPokemonDetailsEvent>(_fetchPokemonDetails);
    on<ToggleFavoriteEvent>(_toggleFavorite);
    on<CheckIfFavoriteEvent>(_checkIfFavorite);
    on<LoadEvolutionEvent>(_onLoadEvolution);
  }

  Future<void> _fetchPokemonDetails(
    FetchPokemonDetailsEvent event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    emit(state.copyWith(status: PokemonDetailsStatus.loading));

    final result = await _getPokemonDetailsUseCase(event.id);

    result.fold(
      (AppError error) => emit(
        state.copyWith(
          status: PokemonDetailsStatus.error,
          errorMessage: error.errorMsg,
        ),
      ),
      (pokemonData) => emit(
        state.copyWith(
          status: PokemonDetailsStatus.loaded,
          pokemon: pokemonData,
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    final result = await _toggleFavoriteUseCase(event.pokemon.id);

    result.fold(
      (AppError error) => emit(
        state.copyWith(
          status: PokemonDetailsStatus.error,
          errorMessage: error.errorMsg,
        ),
      ),
      (isNowFavorite) => emit(state.copyWith(isFavorite: isNowFavorite)),
    );
  }

  Future<void> _checkIfFavorite(
    CheckIfFavoriteEvent event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    final result = await _checkIfFavoriteUseCase(event.pokemonId);

    result.fold(
      (AppError error) => emit(
        state.copyWith(
          status: PokemonDetailsStatus.error,
          errorMessage: error.errorMsg,
        ),
      ),
      (isFavorite) => emit(state.copyWith(isFavorite: isFavorite)),
    );
  }

  Future<void> _onLoadEvolution(
    LoadEvolutionEvent event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    emit(state.copyWith(isEvolutionLoading: true, evolutionChain: []));

    final result = await _getEvolutionChainUseCase(event.pokemonId);

    result.fold(
      (error) => emit(state.copyWith(isEvolutionLoading: false)),
      (evolutions) => emit(
        state.copyWith(isEvolutionLoading: false, evolutionChain: evolutions),
      ),
    );
  }
}
