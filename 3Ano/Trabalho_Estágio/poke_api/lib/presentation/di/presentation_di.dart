import 'package:get_it/get_it.dart';

import '../ui/details/bloc/pokemon_details_bloc.dart';
import '../ui/favorites/bloc/favorites_bloc.dart';
import '../ui/pokemon/bloc/pokemon_bloc.dart';

final _injector = GetIt.instance;

void setUpPresentationDi() {
  _injector.registerFactory(
    () => PokemonBloc(_injector(), _injector(), _injector()),
  );

  _injector.registerFactory(
    () =>
        PokemonDetailsBloc(_injector(), _injector(), _injector(), _injector()),
  );

  _injector.registerFactory(() => FavoritesBloc(_injector()));
}
