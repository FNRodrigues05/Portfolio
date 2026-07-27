import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/pokemon.dart';
import '../ui/details/page/pokemon_details_page.dart';
import '../ui/favorites/page/favorites_page.dart';
import '../ui/pokemon/page/pokemon_page.dart';

sealed class Routes {
  static const initial = homePage;
  static const homePage = 'PokemonPage';

  static const detailsPage = 'DetailsPage';
  static const favoritesPage = 'FavoritesPage';

  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.red,
        body: Center(child: Text('Página não encontrada')),
      );
    },
    initialLocation: '/$initial',
    routes: routes,
  );

  static List<RouteBase> routes = [
    GoRoute(
      path: '/$homePage',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const PokemonPage(),
          transitionDuration: const Duration(milliseconds: 500),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        GoRoute(
          name: detailsPage,
          path: detailsPage,
          pageBuilder: (context, state) {
            final pokemon = state.extra as Pokemon;
            return CustomTransitionPage(
              key: state.pageKey,
              child: PokemonDetailsPage(pokemon: pokemon),
              transitionDuration: const Duration(milliseconds: 500),

              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            );
          },
        ),
        GoRoute(
          name: favoritesPage,
          path: favoritesPage,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const FavoritesPage(),
              transitionDuration: const Duration(milliseconds: 300),

              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ),
                          ),
                      child: child,
                    );
                  },
            );
          },
        ),
      ],
    ),
  ];
}
