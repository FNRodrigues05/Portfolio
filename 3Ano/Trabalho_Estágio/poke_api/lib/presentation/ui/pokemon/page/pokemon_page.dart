import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/pokemon_bloc.dart';
import '../page/pokemon_layout.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<PokemonBloc>()..add(const LoadPokemonEvent()),
      child: const PokemonLayout(),
    );
  }
}
