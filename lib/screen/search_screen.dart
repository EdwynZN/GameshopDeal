import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/screen/home_screen.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';

class SearchScreen extends StatelessWidget {
  final Filter filter;
  const SearchScreen({Key key, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
    return ProviderScope(
      overrides: [
        filterProvider.overrideWithValue(StateController<Filter>(filter))
      ],
      child: Navigator(
        onGenerateRoute: Routes.getRoute,
        initialRoute: homeRoute,
      ),
    );
  }
}
