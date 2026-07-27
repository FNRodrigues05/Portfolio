import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_api/core/l10n/generated/app_localizations.dart';

import '../../../routes/routes.dart';
import '../../../ui/favorites/bloc/favorites_bloc.dart';
import '../../widgets/pokemon_types.dart';

class FavoritesLayout extends StatefulWidget {
  const FavoritesLayout({super.key});

  @override
  State<FavoritesLayout> createState() => _FavoritesLayoutState();
}

class _FavoritesLayoutState extends State<FavoritesLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        title: Text(
          AppLocalizations.of(context)!.favoritesTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.status.isError) {
            return Center(
              child: Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${AppLocalizations.of(context)!.error}: ${state.errorMessage}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ),
            );
          }
          if (state.status.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Lottie.asset(
                    'assets/animations/favorites_broken_heart.json',
                    height: 250,
                    width: 250,
                    repeat: false,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context)!.favoritesNotFound,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 16,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: state.pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = state.pokemons[index];

              final List<Color> coresDoPokemon = pokemon.types!.map((tipo) {
                final typeEnum = PokemonTypes.values.firstWhere(
                  (e) => e.name.toLowerCase() == tipo.toLowerCase(),
                );
                return typeEnum.baseColor;
              }).toList();

              if (coresDoPokemon.length == 1) {
                coresDoPokemon.add(coresDoPokemon.first);
              }

              return InkWell(
                onTap: () async {
                  await context.pushNamed(Routes.detailsPage, extra: pokemon);
                  if (context.mounted) {
                    context.read<FavoritesBloc>().add(
                      const LoadFavoritesEvent(),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    elevation: 6,
                    shadowColor: Theme.of(
                      context,
                    ).colorScheme.onSecondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: coresDoPokemon,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Hero(
                                tag: pokemon.id,
                                child: CachedNetworkImage(
                                  imageUrl: pokemon.imageUrl,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                  errorWidget: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.catching_pokemon,
                                      size: 50,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceDim,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              pokemon.name.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
