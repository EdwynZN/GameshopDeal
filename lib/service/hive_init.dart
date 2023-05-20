
import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/cache_object_adapter.dart';
import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/price_alert.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/preference.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gameshop_deals/model/theme_mode_adapter_enum.dart';
import 'package:gameshop_deals/model/view_enum.dart' as viewEnum;
import 'package:gameshop_deals/utils/preferences_constants.dart'
    show preferenceHiveBox;
import 'package:flutter_cache_manager/src/storage/cache_object.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter<CacheObject>(CacheObjectAdapter())
    ..registerAdapter<ThemeMode>(ThemeModeAdapter())
    ..registerAdapter<viewEnum.View>(viewEnum.ViewAdapter())
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
