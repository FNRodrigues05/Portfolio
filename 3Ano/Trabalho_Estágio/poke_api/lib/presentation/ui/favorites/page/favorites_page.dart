import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:poke_api/presentation/ui/favorites/bloc/favorites_bloc.dart';

import 'favorites_layout.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance<FavoritesBloc>()..add(const LoadFavoritesEvent()),
      child: const FavoritesLayout(),
    );
  }
}
