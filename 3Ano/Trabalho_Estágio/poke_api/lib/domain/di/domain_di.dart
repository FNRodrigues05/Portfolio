import 'package:get_it/get_it.dart';
import 'package:poke_api/domain/use_cases/get_evolution_chain_use_case.dart';
import 'package:poke_api/domain/use_cases/get_pokemons_types_use_case.dart';

import '../repositories/pokemon_repository.dart';
import '../use_cases/check_if_favorite_use_case.dart';
import '../use_cases/get_favorite_pokemons_use_case.dart';
import '../use_cases/get_pokemon_details_use_case.dart';
import '../use_cases/get_pokemons_use_case.dart';
import '../use_cases/toggle_favorite_use_case.dart';

final _injector = GetIt.instance;
//Use Cases
void setUpDomainDi() {
  //Pokemon Page
  _injector.registerFactory<GetPokemonsUseCase>(
    () => GetPokemonsUseCase(_injector<PokemonRepository>()),
  );
  _injector.registerFactory<GetPokemonDetailsUseCase>(
    () => GetPokemonDetailsUseCase(_injector<PokemonRepository>()),
  );
  _injector.registerFactory<GetPokemonsTypesUseCase>(
    () => GetPokemonsTypesUseCase(_injector<PokemonRepository>()),
  );

  //Pokemon Details Page
  _injector.registerFactory<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(_injector<PokemonRepository>()),
  );
  _injector.registerFactory<CheckIfFavoriteUseCase>(
    () => CheckIfFavoriteUseCase(_injector<PokemonRepository>()),
  );
  _injector.registerFactory<GetEvolutionChainUseCase>(
    () => GetEvolutionChainUseCase(_injector<PokemonRepository>()),
  );

  //Favorites Page
  _injector.registerFactory<GetFavoritePokemonsUseCase>(
    () => GetFavoritePokemonsUseCase(_injector<PokemonRepository>()),
  );
}
