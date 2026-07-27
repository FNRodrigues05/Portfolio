import 'package:get_it/get_it.dart';

import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_local_datasource.dart';
import '../datasources/pokemon_remote_datasource.dart';
import '../repositories/pokemon_repository_impl.dart';

final injector = GetIt.instance;

void setUpDataDi() {
  injector.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSource(client: injector()),
  );

  injector.registerLazySingleton<PokemonLocalDataSource>(
    () => PokemonLocalDataSource(prefs: injector()),
  );

  injector.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
      injector<PokemonRemoteDataSource>(),
      injector<PokemonLocalDataSource>(),
    ),
  );
}
