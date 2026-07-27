import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/use_cases/get_favorite_pokemons_use_case.dart';
import 'package:poke_api/presentation/ui/favorites/bloc/favorites_bloc.dart';

class FakeGetFavoritePokemonsUseCase implements GetFavoritePokemonsUseCase {
  bool shouldFail = false;
  bool isEmpty = false;

  final fakeFavorites = [
    const Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url'),
  ];

  @override
  Future<Either<AppError, List<Pokemon>>> call() async {
    if (shouldFail) return Left(AppError('Erro ao carregar favoritos'));
    if (isEmpty) return const Right([]);
    return Right(fakeFavorites);
  }
}

void main() {
  late FakeGetFavoritePokemonsUseCase fakeGetFavorites;

  setUp(() {
    fakeGetFavorites = FakeGetFavoritePokemonsUseCase();
  });

  group('FavoritesBloc - LoadFavoritesEvent', () {
    blocTest<FavoritesBloc, FavoritesState>(
      'Deve emitir [loading, loaded] quando existirem favoritos',
      build: () {
        fakeGetFavorites.shouldFail = false;
        fakeGetFavorites.isEmpty = false;
        return FavoritesBloc(fakeGetFavorites);
      },
      act: (bloc) => bloc.add(const LoadFavoritesEvent()),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        FavoritesState(
          status: FavoritesStatus.loaded,
          pokemons: fakeGetFavorites.fakeFavorites,
        ),
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'Deve emitir [loading, empty] quando não houver favoritos',
      build: () {
        fakeGetFavorites.shouldFail = false;
        fakeGetFavorites.isEmpty = true;
        return FavoritesBloc(fakeGetFavorites);
      },
      act: (bloc) => bloc.add(const LoadFavoritesEvent()),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        const FavoritesState(status: FavoritesStatus.empty),
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'Deve emitir [loading, error] quando o caso de uso falhar',
      build: () {
        fakeGetFavorites.shouldFail = true;
        return FavoritesBloc(fakeGetFavorites);
      },
      act: (bloc) => bloc.add(const LoadFavoritesEvent()),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        const FavoritesState(
          status: FavoritesStatus.error,
          errorMessage: 'Erro ao carregar favoritos',
        ),
      ],
    );
  });
}
