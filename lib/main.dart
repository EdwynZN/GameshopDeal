import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/cache_object_adapter.dart';
import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/price_alert.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/preference.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:gameshop_deals/model/theme_mode_adapter_enum.dart';
import 'package:gameshop_deals/model/view_enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart' show preferenceHiveBox;
import 'package:flutter_cache_manager/src/storage/cache_object.dart';

class Logger extends ProviderObserver {
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print('disposed: ${provider.name}');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue, Object? old, ProviderContainer container) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    print('''
    {
      "providerAdded": "${provider.name ?? provider.runtimeType}",
      "valueType": "${value.runtimeType}"
    }''');
    super.didAddProvider(provider, value, container);
  }
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter<CacheObject>(CacheObjectAdapter())
    ..registerAdapter<ThemeMode>(ThemeModeAdapter())
    ..registerAdapter<View>(ViewAdapter())
    ..registerAdapter<GameLookup>(GameLookupAdapter())
    ..registerAdapter<Info>(InfoAdapter())
    ..registerAdapter<CheapestPrice>(CheapestPriceAdapter())
    ..registerAdapter<Deal>(DealAdapter())
    ..registerAdapter<SortBy>(SortByAdapter())
    ..registerAdapter<Filter>(FilterAdapter())
    ..registerAdapter<PriceAlert>(PriceAlertAdapter())
    ..registerAdapter<Preference>(PreferenceAdapter());
  await Hive.openBox<dynamic>(preferenceHiveBox);
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
  const GameShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeData = ref.watch(themeProvider.notifier);
    return RefreshConfiguration(
      enableLoadingWhenFailed: false,
      autoLoad: true,
      headerBuilder: () => WaterDropMaterialHeader(
        backgroundColor: themeData.lightTheme.appBarTheme.backgroundColor,
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