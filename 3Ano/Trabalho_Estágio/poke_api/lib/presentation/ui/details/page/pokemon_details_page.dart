import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/entities/pokemon.dart';
import '../bloc/pokemon_details_bloc.dart';
import 'pokemon_details_layout.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<PokemonDetailsBloc>()
        ..add(FetchPokemonDetailsEvent(pokemon.id))
        ..add(CheckIfFavoriteEvent(pokemon.id))
        ..add(LoadEvolutionEvent(pokemon.id)),
      child: PokemonDetailsLayout(pokemon: pokemon),
    );
  }
}
