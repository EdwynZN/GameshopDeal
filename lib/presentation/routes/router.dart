import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/presentation/screen/game_detail.dart';
import 'package:gameshop_deals/presentation/screen/home.dart';
import 'package:gameshop_deals/presentation/screen/saved_deals.dart';
import 'package:gameshop_deals/presentation/screen/settings.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GoRouter createRouter({
  String initial = '/',
  bool routerNeglect = true,
  bool debugLogDiagnostics = kDebugMode,
  List<NavigatorObserver>? observers,
}) {
  return GoRouter(
    debugLogDiagnostics: debugLogDiagnostics,
    errorBuilder: (_, __) => const Material(),
    routerNeglect: routerNeglect,
    initialLocation: initial,
    observers: observers,
    routes: [
      GoRoute(
        name: 'home',
        path: homeRoute,
        builder: (_, __) => const Home(),
        routes: [
          GoRoute(
            name: savedGamesRoute,
            path: savedGamesRoute,
            builder: (_, state) => const SavedGamesPage(),
          ),
          GoRoute(
            name: settingsName,
            path: settingsName,
            builder: (_, __) => const SettingsScreen(),
          ),
          GoRoute(
            name: detailName,
            path: '$detailRoute/:id',
            redirect: (context, state) {
              final id = state.pathParameters['id']!;
              return int.tryParse(id) == null
                ? '/'
                : null;
            },
            builder:(_, state) {
              final id = state.pathParameters['id']!;
              return GameDetailScreen(id: int.parse(id));
            },
          ),
          GoRoute(
            name: 'search_response',
            path: searchRoute,
            redirect: (context, state) {
              final search = state.queryParameters['title'];
              return search == null || search.isEmpty ? '/' : null;
            },
            builder: (_, state) {
              final search = state.queryParameters['title']!;
              return ProviderScope(
                overrides: [titleProvider.overrideWithValue(search)],
                child: const Home(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
