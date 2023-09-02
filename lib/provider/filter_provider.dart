import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final titleProvider = Provider<String>((_) => '', name: 'TitleSearch');

final filterProvider = StateProvider.autoDispose.family<Filter, String>(
  (ref, title) {
    final preferedBox = ref.watch(hivePreferencesProvider);
    final Filter filter = preferedBox.get(filterKey, defaultValue: Filter());
    return filter.copyWith(title: title);
  },
  name: 'FilterProvider',
);