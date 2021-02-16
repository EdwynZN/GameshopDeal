import 'package:flutter/material.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';

class GameLookupScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  GameLookupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = navigationKey.currentState;
        if (!navigator.canPop()) return true;
        navigator.pop();
        return false;
      },
      child: Navigator(
        key: navigationKey,
        onGenerateRoute: Routes.getSavedGamesRoute,
        initialRoute: homeRoute,
      ),
    );
  }
}
