import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter_model.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart';

final _storesProvider = Provider.autoDispose((ref) =>
  ref.watch(filterProviderCopy).state.storeId,
  name: 'Stores ID'
);

class StoreWidget extends ConsumerWidget{
  const StoreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
        List<Store> activeStores = stores.where((element) => element.isActive).toList();
        return Wrap(
          spacing: 8,
          children: <Widget>[
            ChoiceChip(
              selected: storesSelected.isEmpty,
              onSelected: (val)  {
                //if(val) return;
                final StateController<Filter> filter = context.read(filterProviderCopy);
                filter.state = filter.state.copyWith(stores: <int>{});
              },
              label: const Text('All'),
              avatar: const Icon(Icons.all_inclusive, size: 20,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                      topRight: Radius.circular(4),
                      topLeft: Radius.circular(4)
                  )
              ),
              tooltip: 'All',
            ),
            for(Store store in activeStores)
              ChoiceChip(
                selected: storesSelected.contains(int.tryParse(store.storeId)),
                onSelected: (val) {
                  final StateController<Filter> filter = context.read(filterProviderCopy);
                  Set<int> set = Set<int>.from(storesSelected);
                  if(val) set.add(int.tryParse(store.storeId));
                  else set.remove(int.tryParse(store.storeId));
                  filter.state = filter.state.copyWith(stores: set);
                },
                label: Text(store.storeName),
                avatar: CachedNetworkImage(
                  imageUrl: 'https://www.cheapshark.com${store.images.icon}',
                  fit: BoxFit.contain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(4)
                  )
                ),
                tooltip: store.storeName,
              ),
          ],
        );
      },
    );
  }
}
