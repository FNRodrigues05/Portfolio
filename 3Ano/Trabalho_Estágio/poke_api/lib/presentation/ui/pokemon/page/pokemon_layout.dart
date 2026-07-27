import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_api/core/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../theme/theme_provider.dart';
import '../../../routes/routes.dart';
import '../../widgets/pokemon_types.dart';
import '../bloc/pokemon_bloc.dart';

class PokemonLayout extends StatefulWidget {
  const PokemonLayout({super.key});

  @override
  State<PokemonLayout> createState() => _PokemonLayoutState();
}

class _PokemonLayoutState extends State<PokemonLayout> {
  final TextEditingController _searchController = TextEditingController();
  late bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    context.read<PokemonBloc>().add(const LoadFavoritesEvent());
    context.read<PokemonBloc>().add(const LoadPokemonEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                state.isSearching ? Icons.close : Icons.search,
                size: 30,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                if (state.isSearching) {
                  _searchController.clear();
                  context.read<PokemonBloc>().add(
                    const FilterByTypeEvent('Todos'),
                  );
                }
                context.read<PokemonBloc>().add(const ToggleSearchEvent());
              },
              tooltip: state.isSearching
                  ? AppLocalizations.of(context)!.closeSearchButtonTooltip
                  : AppLocalizations.of(context)!.searchButtonTooltip,
            ),
            title: state.isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchLabel,
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (query) {
                      context.read<PokemonBloc>().add(
                        SearchPokemonEvent(query),
                      );
                    },
                  )
                : Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
            centerTitle: true,

            actions: [
              if (state.isSearching)
                DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: .none,
                    focusedBorder: .none,
                    enabledBorder: .none,
                  ),
                  menuHeight: 300,
                  width: 140,
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  initialSelection: AppLocalizations.of(context)!.everyType,
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(
                      enabled: true,
                      value: 'Todos',
                      label: AppLocalizations.of(context)!.everyType,
                      leadingIcon: const FaIcon(
                        FontAwesomeIcons.globe,
                        color: Colors.indigo,
                      ),
                      style: MenuItemButton.styleFrom(
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer,
                        textStyle: const TextStyle(
                          fontWeight: .bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    for (final type in PokemonTypes.values)
                      DropdownMenuEntry(
                        value: type.name.toLowerCase(),
                        label: type.getLocalizedName(context),
                        leadingIcon: FaIcon(type.icon, color: type.iconColor),
                        style: MenuItemButton.styleFrom(
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          textStyle: const TextStyle(
                            fontWeight: .bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                  onSelected: (value) {
                    context.read<PokemonBloc>().add(
                      FilterByTypeEvent(value.toString()),
                    );
                  },
                )
              else
                IconButton(
                  icon: FaIcon(
                    isDarkMode
                        ? FontAwesomeIcons.solidMoon
                        : FontAwesomeIcons.solidSun,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  tooltip: isDarkMode
                      ? AppLocalizations.of(context)!.lightModeButtonTooltip
                      : AppLocalizations.of(context)!.darkModeButtonTooltip,
                  onPressed: () {
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme();
                    isDarkMode = !isDarkMode;
                  },
                ),
              const SizedBox(width: 10),
            ],

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

          body: BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              if (state.status.isLoading || state.pokemons.isEmpty) {
                return Skeletonizer(
                  enabled: true,
                  effect: ShimmerEffect(
                    baseColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh,
                    highlightColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerLowest,
                    duration: const Duration(seconds: 2),
                  ),
                  child: ListView.builder(
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Bone.square(
                          size: 50,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        horizontalTitleGap: 50,
                        title: Bone.text(
                          words: 2,
                          style: TextStyle(fontWeight: .bold, fontSize: 16),
                        ),
                        subtitle: Bone.text(
                          words: 1,
                          style: TextStyle(fontWeight: .bold, fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Skeleton.keep(
                              child: Icon(
                                Icons.favorite,
                                size: 20,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                                fontWeight: .bold,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Skeleton.keep(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              if (state.status.isError) {
                return Center(
                  child: Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context)!.pokemonLoadingError,
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (state.status.isLoaded) {
                if (state.filteredPokemons.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Lottie.asset(
                          'assets/animations/pokemon_not_found.json',
                          width: 250,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              AppLocalizations.of(context)!.pokemonNotFound,
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
                return ListView.builder(
                  itemCount: state.filteredPokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = state.filteredPokemons[index];
                    final isFavorite = state.favoriteIds.contains(
                      pokemon.id.toString(),
                    );

                    return ListTile(
                      leading: Hero(
                        tag: pokemon.id,
                        child: CachedNetworkImage(
                          imageUrl: pokemon.imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          errorWidget: (context, error, stackTrace) {
                            return Icon(
                              Icons.catching_pokemon,
                              size: 50,
                              color: Theme.of(context).colorScheme.surfaceDim,
                            );
                          },
                        ),
                      ),
                      horizontalTitleGap: 50,
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: .centerLeft,
                        child: Text(
                          pokemon.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        '#${pokemon.id.toString().padLeft(4, '0')}',
                      ),
                      onTap: () async {
                        await context.pushNamed(
                          Routes.detailsPage,
                          extra: pokemon,
                        );
                        if (context.mounted) {
                          context.read<PokemonBloc>().add(
                            const LoadFavoritesEvent(),
                          );
                        }
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isFavorite)
                            Icon(
                              Icons.favorite,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 20,
                            ),
                          const SizedBox(width: 30),
                          Icon(Icons.arrow_forward_ios, size: 25),
                        ],
                      ),
                    );
                  },
                );
              }

              return Center(
                child: Text(AppLocalizations.of(context)!.pokemonNotFound),
              );
            },
          ),
          floatingActionButtonLocation: .endDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () async {
              await context.pushNamed(Routes.favoritesPage);
              if (context.mounted) {
                context.read<PokemonBloc>().add(const LoadFavoritesEvent());
              }
            },
            tooltip: AppLocalizations.of(context)!.favoritesButtonTooltip,
            child: Icon(
              Icons.favorite,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      },
    );
  }
}
