import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/presentation/screen/home.dart';
import 'package:go_router/go_router.dart';

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
        path: '/',
        builder: (_, __) => const Home(),
      ),
    ],
  );
}
