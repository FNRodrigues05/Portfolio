import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poke_api/core/l10n/generated/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../domain/entities/pokemon.dart';
import '../../widgets/pokemon_stats.dart';
import '../../widgets/pokemon_types.dart';
import '../bloc/pokemon_details_bloc.dart';

class PokemonDetailsLayout extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsLayout({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        DelightToastBar.removeAll();
      },
      child: BlocConsumer<PokemonDetailsBloc, PokemonDetailsState>(
        listenWhen: (previous, current) =>
            previous.status.isLoaded &&
            previous.isFavorite != current.isFavorite,
        listener: (context, state) {
          DelightToastBar.removeAll();
          if (state.isFavorite) {
            showDialog(
              context: context,
              barrierDismissible: true,
              barrierColor: Colors.black.withValues(alpha: 0.6),
              builder: (BuildContext dialogContext) {
                Future.delayed(const Duration(milliseconds: 1500), () {
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                });
                return GestureDetector(
                  onTap: () {
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,

                    insetPadding: EdgeInsets.zero,
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/pokemon_favorited.json',
                        width: 250,
                        height: 250,
                        repeat: false,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            DelightToastBar(
              autoDismiss: true,
              position: DelightSnackbarPosition.bottom,
              snackbarDuration: const Duration(seconds: 2),
              builder: (BuildContext context) => ToastCard(
                color: Theme.of(context).colorScheme.surfaceContainer,
                title: Text(
                  AppLocalizations.of(
                    context,
                  )!.removedFavorites(pokemon.name.toUpperCase()),
                  style: const TextStyle(fontWeight: .bold, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                leading: Icon(
                  state.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 28,
                ),
              ),
            ).show(context);
          }
        },
        builder: (context, state) {
          final displayPokemon =
              (state.status.isLoaded && state.pokemon != null)
              ? state.pokemon!
              : pokemon;

          List<Color> coresDoPokemon = [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ];

          if (displayPokemon.types != null) {
            coresDoPokemon = displayPokemon.types!.map((tipo) {
              final typeEnum = PokemonTypes.values.firstWhere(
                (e) => e.name.toLowerCase() == tipo.toLowerCase(),
              );
              return typeEnum.baseColor;
            }).toList();

            if (coresDoPokemon.length == 1) {
              coresDoPokemon.add(coresDoPokemon.first);
            }
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              title: Text(
                AppLocalizations.of(
                  context,
                )!.detailsPageTitle(displayPokemon.name.toUpperCase()),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 19,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                  onPressed: () {
                    context.read<PokemonDetailsBloc>().add(
                      ToggleFavoriteEvent(displayPokemon),
                    );
                  },
                  tooltip: state.isFavorite
                      ? AppLocalizations.of(
                          context,
                        )!.removeFavoriteButtonTooltip
                      : AppLocalizations.of(context)!.addFavoriteButtonTooltip,
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
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: coresDoPokemon,
                  stops: [0.0, 0.5],
                  begin: .topLeft,
                  end: .bottomLeft,
                ),
              ),
              child: Column(
                children: [
                  SafeArea(
                    bottom: false,
                    child: SizedBox(
                      height: 220,
                      child: Center(
                        child: Hero(
                          tag: displayPokemon.id,
                          child: Transform.scale(
                            scale: 1,
                            child: CachedNetworkImage(
                              imageUrl: displayPokemon.imageUrl,
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
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          top: 30,
                          left: 20,
                          right: 20,
                          bottom: 30 + MediaQuery.of(context).padding.bottom,
                        ),
                        child: Column(
                          children: [
                            Text(
                              displayPokemon.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: .center,
                              children: [
                                Text(
                                  '#${pokemon.id.toString().padLeft(4, '0')}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 8),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.volume_up_rounded),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                    iconSize: 24,
                                    tooltip: AppLocalizations.of(
                                      context,
                                    )?.cryButtonToolTip,
                                    onPressed: () async {
                                      await AudioPlayer().play(
                                        UrlSource(
                                          'https://play.pokemonshowdown.com/audio/cries/${displayPokemon.name.toLowerCase()}.mp3',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            if (displayPokemon.types != null)
                              Wrap(
                                spacing: 12,
                                children: displayPokemon.types!.map((type) {
                                  final typeEnum = PokemonTypes.values
                                      .firstWhere(
                                        (e) =>
                                            e.name.toLowerCase() ==
                                            type.toLowerCase(),
                                      );
                                  return Chip(
                                    shadowColor: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
                                    backgroundColor: typeEnum.baseColor,
                                    side: BorderSide.none,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    label: Text(
                                      typeEnum
                                          .getLocalizedName(context)
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                            const SizedBox(height: 35),

                            if (state.status.isLoading)
                              Skeletonizer(
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
                                child: Column(
                                  children: [
                                    Wrap(
                                      spacing: 12,
                                      children: [
                                        Bone.button(
                                          width: 80,
                                          height: 30,
                                          borderRadius: .circular(10),
                                        ),
                                        Bone.button(
                                          width: 80,
                                          height: 30,
                                          borderRadius: .circular(10),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 35),
                                    Row(
                                      crossAxisAlignment: .start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              const Bone.text(
                                                words: 2,
                                                fontSize: 20,
                                              ),
                                              const SizedBox(height: 25),
                                              Row(
                                                children: [
                                                  const Bone.icon(size: 28),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          .start,
                                                      children: [
                                                        const Bone.text(
                                                          words: 1,
                                                          fontSize: 14,
                                                        ),
                                                        SizedBox(height: 5),
                                                        const Bone.text(
                                                          words: 1,
                                                          fontSize: 16,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 25),
                                              Row(
                                                children: [
                                                  const Bone.icon(size: 28),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          .start,
                                                      children: [
                                                        const Bone.text(
                                                          words: 1,
                                                          fontSize: 14,
                                                        ),
                                                        SizedBox(height: 5),
                                                        const Bone.text(
                                                          words: 1,
                                                          fontSize: 16,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 15),

                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              const Bone.text(
                                                words: 2,
                                                fontSize: 20,
                                              ),
                                              const SizedBox(height: 25),

                                              for (int i = 0; i < 6; i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 6,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Bone.text(
                                                          words: 2,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Bone.text(
                                                        words: 1,
                                                        fontSize: 13,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            else if (state.status.isError)
                              Card(
                                color: Theme.of(
                                  context,
                                ).colorScheme.errorContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    '${AppLocalizations.of(context)!.error}: ${state.errorMessage}',
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      fontSize: 16,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onErrorContainer,
                                    ),
                                  ),
                                ),
                              )
                            else ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.physicalTraits,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.height,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.outline,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${((displayPokemon.height ?? 0) / 10)} m",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.height,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.scale_outlined,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.outline,
                                              size: 28,
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${((displayPokemon.weight ?? 0) / 10)} kg",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.weight,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.baseStats,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        if (displayPokemon.stats != null)
                                          for (final stat
                                              in displayPokemon.stats!.entries)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 6,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child:
                                                        getLocalizationStats(
                                                          context,
                                                          stat.key,
                                                        ).contains(' ')
                                                        ? Text(
                                                            getLocalizationStats(
                                                              context,
                                                              stat.key,
                                                            ).toUpperCase(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Theme.of(
                                                                        context,
                                                                      )
                                                                      .colorScheme
                                                                      .onSurface,
                                                              fontSize: 13,
                                                            ),
                                                          )
                                                        : FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              getLocalizationStats(
                                                                context,
                                                                stat.key,
                                                              ).toUpperCase(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                  context,
                                                                ).colorScheme.onSurface,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                      stat.value
                                                          .toString()
                                                          .padLeft(3, '0'),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurfaceVariant,
                                                        fontSize: 13,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    flex: 2,
                                                    child: TweenAnimationBuilder<double>(
                                                      tween: Tween<double>(
                                                        begin: 0.0,
                                                        end: stat.value / 255.0,
                                                      ),
                                                      duration: const Duration(
                                                        milliseconds: 1200,
                                                      ),
                                                      curve:
                                                          Curves.easeOutCubic,
                                                      builder: (context, value, _) {
                                                        Color corDaBarra;
                                                        if (stat.value < 50) {
                                                          corDaBarra =
                                                              Colors.redAccent;
                                                        } else if (stat.value <
                                                            90) {
                                                          corDaBarra = Colors
                                                              .orangeAccent;
                                                        } else if (stat.value <
                                                            150) {
                                                          corDaBarra =
                                                              Colors.green;
                                                        } else {
                                                          corDaBarra =
                                                              Colors.blue;
                                                        }
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          child: LinearProgressIndicator(
                                                            value: value,
                                                            minHeight: 8,
                                                            backgroundColor:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .surfaceContainerHighest,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                  Color
                                                                >(corDaBarra),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Text(
                                AppLocalizations.of(context)!.evolutionChain,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 25),
                              if (state.isEvolutionLoading)
                                Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                )
                              else if (state.evolutionChain.isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: state.evolutionChain.map((evo) {
                                      final isCurrent =
                                          evo.id == displayPokemon.id;

                                      return Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isCurrent
                                                      ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withValues(
                                                              alpha: 0.2,
                                                            )
                                                      : Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: evo.imageUrl,
                                                  height: 70,
                                                  width: 70,
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Icon(
                                                        Icons.catching_pokemon,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surfaceDim,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                evo.name.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: isCurrent
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: isCurrent
                                                      ? Theme.of(
                                                          context,
                                                        ).colorScheme.primary
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.onSurface,
                                                ),
                                              ),
                                            ],
                                          ),

                                          if (evo != state.evolutionChain.last)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.outline,
                                                size: 20,
                                              ),
                                            ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
