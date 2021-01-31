import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';

class SearchScreen extends StatelessWidget {
  final String title;
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  SearchScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = navigationKey.currentState;
        if (!navigator.canPop()) return true;
        navigator.pop();
        return false;
      },
      child: ProviderScope(
        overrides: [titleProvider.overrideWithValue(title)],
        child: Navigator(
          key: navigationKey,
          onGenerateRoute: Routes.getSearchRoute,
          initialRoute: homeRoute,
        ),
      ),
    );
  }
}