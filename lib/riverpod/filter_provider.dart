import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';

final titleProvider = ScopedProvider<String>((_) => '', name: 'TitleSearch');

final filterProviderCopy = StateProvider.autoDispose.family<Filter, String>(
  (ref, title) => ref.read(filterProvider(title)).state.copyWith(),
  name: 'FilterScreen',
);

final filterProvider = StateProvider.autoDispose.family<Filter, String>(
  (ref, title) {
    final preferedBox = ref.watch(preferencesProvider);
    final Filter filter =
        preferedBox.get('filter', defaultValue: Filter()) as Filter;
    return filter.copyWith(title: title);
  },
  name: 'FilterProvider',
);