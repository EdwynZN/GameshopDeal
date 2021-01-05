import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show storesProvider;
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart' show cheapsharkUrl;

final _storesProvider = ScopedProvider<Set<int>>(
  (watch) => watch(filterProviderCopy).state.storeID,
  name: 'Stores ID',
);

class StoreWidget extends ConsumerWidget {
  const StoreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final Set<int> storesSelected = watch(_storesProvider);
    final stores = watch(storesProvider);
    return stores.when(
      loading: () => const Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const LinearProgressIndicator(minHeight: 4),
      ),
      error: (err, stack) => OutlinedButton(
        child: Text('Error fetching the stores'),
        onPressed: () => context.refresh(storesProvider),
      ),
      data: (stores) {
        List<Store> activeStores =
            stores.where((element) => element.isActive).toList();
        return Wrap(
          spacing: 8,
          children: <Widget>[
            ChoiceChip(
              selected: storesSelected.isEmpty,
              onSelected: (val) {
                final StateController<Filter> filter =
                    context.read(filterProviderCopy);
                filter.state = filter.state.copyWith(storeID: <int>{});
              },
              label: Text(translate.all_choice),
              avatar: const Icon(
                Icons.all_inclusive,
                size: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              tooltip: translate.all_stores_tooltip,
            ),
            for (Store store in activeStores)
              ChoiceChip(
                selected: storesSelected.contains(int.tryParse(store.storeId)),
                onSelected: (val) {
                  final StateController<Filter> filter =
                      context.read(filterProviderCopy);
                  Set<int> set = Set<int>.from(storesSelected);
                  if (val)
                    set.add(int.tryParse(store.storeId));
                  else
                    set.remove(int.tryParse(store.storeId));
                  filter.state = filter.state.copyWith(storeID: set);
                },
                label: Text(store.storeName),
                avatar: CachedNetworkImage(
                  cacheManager:
                      watch(cacheManagerFamilyProvider(cacheKeyStores)),
                  imageUrl: cheapsharkUrl + store.images.icon,
                  fit: BoxFit.contain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
                tooltip: store.storeName,
              ),
          ],
        );
      },
    );
  }
}
