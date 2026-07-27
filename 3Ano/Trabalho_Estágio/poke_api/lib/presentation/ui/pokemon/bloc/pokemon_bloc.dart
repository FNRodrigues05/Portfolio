import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/pokemon.dart';
import '../../../../domain/errors/app_error.dart';
import '../../../../domain/use_cases/get_favorite_pokemons_use_case.dart';
import '../../../../domain/use_cases/get_pokemons_types_use_case.dart';
import '../../../../domain/use_cases/get_pokemons_use_case.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetPokemonsUseCase _getPokemonsUseCase;
  final GetFavoritePokemonsUseCase _getFavoritePokemonsUseCase;
  final GetPokemonsTypesUseCase _getPokemonsTypesUseCase;

  PokemonBloc(
    this._getPokemonsUseCase,
    this._getFavoritePokemonsUseCase,
    this._getPokemonsTypesUseCase,
  ) : super(const PokemonState()) {
    on<LoadPokemonEvent>(_loadData, transformer: droppable());
    on<SearchPokemonEvent>(_searchData);
    on<ToggleSearchEvent>(_toggleSearch);
    on<LoadFavoritesEvent>(_loadFavorites);
    on<FilterByTypeEvent>(_filterByType);
  }

  Future<void> _loadData(
    LoadPokemonEvent event,
    Emitter<PokemonState> emit,
  ) async {
    final offset = state.pokemons.length;

    if (state.pokemons.isEmpty) {
      emit(state.copyWith(status: PokemonStatus.loading));
    }

    final result = await _getPokemonsUseCase(offset);

    result.fold(
      (AppError error) {
        if (state.pokemons.isNotEmpty) {
          emit(state.copyWith(status: PokemonStatus.loaded));
        } else {
          emit(
            state.copyWith(
              status: PokemonStatus.error,
              errorMessage: error.errorMsg,
            ),
          );
        }
      },
      (newPokemons) {
        if (newPokemons.isEmpty) {
          emit(state.copyWith(status: PokemonStatus.empty));
        } else {
          emit(
            state.copyWith(
              status: PokemonStatus.loaded,
              pokemons: List.of(state.pokemons)..addAll(newPokemons),
            ),
          );
        }
      },
    );
  }

  Future<void> _searchData(
    SearchPokemonEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
  }

  Future<void> _toggleSearch(
    ToggleSearchEvent event,
    Emitter<PokemonState> emit,
  ) async {
    final isNowSearching = !state.isSearching;
    emit(
      state.copyWith(
        isSearching: isNowSearching,
        searchQuery: isNowSearching ? state.searchQuery : '',
      ),
    );
  }

  Future<void> _loadFavorites(
    LoadFavoritesEvent event,
    Emitter<PokemonState> emit,
  ) async {
    final result = await _getFavoritePokemonsUseCase();
    result.fold(
      (AppError error) {
        emit(
          state.copyWith(
            status: PokemonStatus.error,
            errorMessage: error.errorMsg,
          ),
        );
      },
      (pokemons) {
        final favoriteIds = pokemons
            .map((pokemon) => pokemon.id.toString())
            .toList();
        emit(
          state.copyWith(
            status: PokemonStatus.loaded,
            favoriteIds: favoriteIds,
          ),
        );
      },
    );
  }

  Future<void> _filterByType(
    FilterByTypeEvent event,
    Emitter<PokemonState> emit,
  ) async {
    if (event.type == 'Todos') {
      emit(state.copyWith(selectedType: 'Todos', pokemonsOfSelectedType: []));
      return;
    }
    emit(
      state.copyWith(selectedType: event.type, status: PokemonStatus.loading),
    );

    final result = await _getPokemonsTypesUseCase(event.type);

    result.fold(
      (AppError error) {
        emit(
          state.copyWith(
            status: PokemonStatus.error,
            pokemonsOfSelectedType: [],
            errorMessage: error.errorMsg,
          ),
        );
      },
      (pokemons) {
        emit(
          state.copyWith(
            status: PokemonStatus.loaded,
            pokemonsOfSelectedType: pokemons,
          ),
        );
      },
    );
  }
}
