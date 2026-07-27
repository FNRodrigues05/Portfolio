import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/pokemon.dart';
import '../../../../domain/errors/app_error.dart';
import '../../../../domain/use_cases/get_favorite_pokemons_use_case.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritePokemonsUseCase _getFavoritePokemonsUseCase;

  FavoritesBloc(this._getFavoritePokemonsUseCase)
    : super(const FavoritesState()) {
    on<LoadFavoritesEvent>(_loadData);
  }

  Future<void> _loadData(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    final result = await _getFavoritePokemonsUseCase();

    result.fold(
      (AppError error) {
        emit(
          state.copyWith(
            status: FavoritesStatus.error,
            errorMessage: error.errorMsg,
          ),
        );
      },
      (pokemons) {
        if (pokemons.isEmpty) {
          emit(state.copyWith(status: FavoritesStatus.empty));
        } else {
          emit(
            state.copyWith(status: FavoritesStatus.loaded, pokemons: pokemons),
          );
        }
      },
    );
  }
}
