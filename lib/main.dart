import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/preference.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:gameshop_deals/model/theme_mode_adapter_enum.dart';
import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Logger extends ProviderObserver {
  @override
  void didDisposeProvider(ProviderBase provider) {
    print('disposed: ${provider.name}');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object newValue) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void mayHaveChanged(ProviderBase provider) {
    print('''
      {
        "provider changed": "${provider.name ?? provider.runtimeType}",
      }''');
    super.mayHaveChanged(provider);
  }

  @override
  void didAddProvider(ProviderBase provider, Object value) {
    print('''
    {
      "providerAdded": "${provider.name ?? provider.runtimeType}",
      "valueType": "${value.runtimeType}"
    }''');
    super.didAddProvider(provider, value);
  }
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive..registerAdapter<ThemeMode>(ThemeModeAdapter())
    ..registerAdapter<DealView>(DealViewAdapter())
    ..registerAdapter<GameLookup>(GameLookupAdapter())
    ..registerAdapter<Info>(InfoAdapter())
    ..registerAdapter<CheapestPrice>(CheapestPriceAdapter())
    ..registerAdapter<Deal>(DealAdapter())
    ..registerAdapter<SortBy>(SortByAdapter())
    ..registerAdapter<Filter>(FilterAdapter())
    ..registerAdapter<Preference>(PreferenceAdapter());
  await Hive.openBox<dynamic>('preferences');
}

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(
    ProviderScope(
      //observers: [Logger()],
      child: const GameShop(),
    ),
  );
}

class GameShop extends ConsumerWidget {
  const GameShop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeMode = watch(themeProvider.state);
    final themeData = watch(themeProvider);
    return RefreshConfiguration(
      enableLoadingWhenFailed: false,
      autoLoad: true,
      headerBuilder: () => WaterDropMaterialHeader(
        backgroundColor: themeData.lightTheme.appBarTheme.color,
      ),
      //enableScrollWhenRefreshCompleted: true,
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        darkTheme: themeData.darkTheme,
        theme: themeData.lightTheme,
        themeMode: themeMode,
        onGenerateRoute: Routes.getRoute,
        initialRoute: homeRoute,
      ),
    );
  }
}
