import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:poke_api/domain/entities/pokemon.dart';
import 'package:poke_api/domain/errors/app_error.dart';
import 'package:poke_api/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/domain/use_cases/check_if_favorite_use_case.dart';
import 'package:poke_api/domain/use_cases/get_evolution_chain_use_case.dart';
import 'package:poke_api/domain/use_cases/get_pokemon_details_use_case.dart';
import 'package:poke_api/domain/use_cases/toggle_favorite_use_case.dart';
import 'package:poke_api/presentation/ui/details/bloc/pokemon_details_bloc.dart';

class FakeGetPokemonDetailsUseCase implements GetPokemonDetailsUseCase {
  bool shouldFail = false;
  final fakePokemon = const Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url');

  @override
  Future<Either<AppError, Pokemon>> call(int id) async {
    if (shouldFail) return Left(AppError('Erro ao carregar'));
    return Right(fakePokemon);
  }
}

class FakeCheckIfFavoriteUseCase implements CheckIfFavoriteUseCase {
  bool shouldFail = false;
  bool isFav = false;

  @override
  Future<Either<AppError, bool>> call(int id) async {
    if (shouldFail) return Left(AppError('Erro ao verificar'));
    return Right(isFav);
  }
}

class FakeToggleFavoriteUseCase implements ToggleFavoriteUseCase {
  bool shouldFail = false;
  bool toggleResult = true;

  @override
  Future<Either<AppError, bool>> call(int id) async {
    if (shouldFail) return Left(AppError('Erro ao alterar'));
    return Right(toggleResult);
  }
}

class FakeGetEvolutionChainUseCase implements GetEvolutionChainUseCase {
  bool shouldFail = false;
  final fakeEvolutions = [
    const Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url'),
  ];

  @override
  Future<Either<AppError, List<Pokemon>>> call(int id) async {
    if (shouldFail) return Left(AppError('Erro ao carregar evolução'));
    return Right(fakeEvolutions);
  }

  @override
  PokemonRepository get repository => throw UnimplementedError();
}

void main() {
  late FakeGetPokemonDetailsUseCase fakeGetDetails;
  late FakeCheckIfFavoriteUseCase fakeCheckFav;
  late FakeToggleFavoriteUseCase fakeToggleFav;
  late FakeGetEvolutionChainUseCase fakeGetEvolution;

  setUp(() {
    fakeGetDetails = FakeGetPokemonDetailsUseCase();
    fakeCheckFav = FakeCheckIfFavoriteUseCase();
    fakeToggleFav = FakeToggleFavoriteUseCase();
    fakeGetEvolution = FakeGetEvolutionChainUseCase();
  });

  const tPokemonId = 1;
  const tPokemon = Pokemon(id: tPokemonId, name: 'bulbasaur', imageUrl: 'url');

  group('PokemonDetailsBloc - FetchPokemonDetailsEvent', () {
    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve emitir [loading, loaded] quando o fetch tiver sucesso',
      build: () {
        fakeGetDetails.shouldFail = false;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const FetchPokemonDetailsEvent(tPokemonId)),
      expect: () => [
        const PokemonDetailsState(status: PokemonDetailsStatus.loading),
        PokemonDetailsState(
          status: PokemonDetailsStatus.loaded,
          pokemon: fakeGetDetails.fakePokemon,
        ),
      ],
    );

    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve emitir [loading, error] quando o fetch falhar',
      build: () {
        fakeGetDetails.shouldFail = true;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const FetchPokemonDetailsEvent(tPokemonId)),
      expect: () => [
        const PokemonDetailsState(status: PokemonDetailsStatus.loading),
        const PokemonDetailsState(
          status: PokemonDetailsStatus.error,
          errorMessage: 'Erro ao carregar',
        ),
      ],
    );
  });

  group('PokemonDetailsBloc - CheckIfFavoriteEvent', () {
    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve atualizar isFavorite para true quando for favorito',
      build: () {
        fakeCheckFav.shouldFail = false;
        fakeCheckFav.isFav = true;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const CheckIfFavoriteEvent(tPokemonId)),
      expect: () => [const PokemonDetailsState(isFavorite: true)],
    );

    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve emitir erro quando a verificação falhar',
      build: () {
        fakeCheckFav.shouldFail = true;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const CheckIfFavoriteEvent(tPokemonId)),
      expect: () => [
        const PokemonDetailsState(
          status: PokemonDetailsStatus.error,
          errorMessage: 'Erro ao verificar',
        ),
      ],
    );
  });

  group('PokemonDetailsBloc - ToggleFavoriteEvent', () {
    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve atualizar isFavorite após alterar com sucesso',
      build: () {
        fakeToggleFav.shouldFail = false;
        fakeToggleFav.toggleResult = true;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const ToggleFavoriteEvent(tPokemon)),
      expect: () => [const PokemonDetailsState(isFavorite: true)],
    );

    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve emitir erro quando alterar falhar',
      build: () {
        fakeToggleFav.shouldFail = true;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const ToggleFavoriteEvent(tPokemon)),
      expect: () => [
        const PokemonDetailsState(
          status: PokemonDetailsStatus.error,
          errorMessage: 'Erro ao alterar',
        ),
      ],
    );
  });

  group('PokemonDetailsBloc - LoadEvolutionEvent', () {
    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve emitir o loading de evolução e depois a lista carregada',
      build: () {
        fakeGetEvolution.shouldFail = false;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const LoadEvolutionEvent(tPokemonId)),
      expect: () => [
        const PokemonDetailsState(isEvolutionLoading: true, evolutionChain: []),
        PokemonDetailsState(
          isEvolutionLoading: false,
          evolutionChain: fakeGetEvolution.fakeEvolutions,
        ),
      ],
    );

    blocTest<PokemonDetailsBloc, PokemonDetailsState>(
      'Deve emitir loading false com lista vazia caso a evolução falhe',
      build: () {
        fakeGetEvolution.shouldFail = true;
        return PokemonDetailsBloc(
          fakeGetDetails,
          fakeCheckFav,
          fakeToggleFav,
          fakeGetEvolution,
        );
      },
      act: (bloc) => bloc.add(const LoadEvolutionEvent(tPokemonId)),
      expect: () => [
        const PokemonDetailsState(isEvolutionLoading: true, evolutionChain: []),
        const PokemonDetailsState(
          isEvolutionLoading: false,
          evolutionChain: [],
        ),
      ],
    );
  });
}
