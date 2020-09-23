import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoreWidget extends StatefulWidget {
  @override
  _StoreWidgetState createState() => _StoreWidgetState();
}

class _StoreWidgetState extends State<StoreWidget> {
  FilterProvider _filterProvider;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _filterProvider = context.read<FilterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> storesSelected = _filterProvider.storeId.toList();
    final List<Store> stores = context.watch<List<Store>>() ?? const <Store>[];
    return Wrap(
      spacing: 8,
      children: <Widget>[
        ChoiceChip(
          selected: storesSelected.isEmpty,
          onSelected: (val) => setState(() => _filterProvider.storeId.clear()),
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
        for(Store store in stores)
          if(store.isActive)
            ChoiceChip(
              selected: storesSelected.contains(int.tryParse(store.storeId)),
              onSelected: (val) => setState(() {
                if(val) _filterProvider.storeId.add(int.tryParse(store.storeId));
                else _filterProvider.storeId.remove(int.tryParse(store.storeId));
              }),
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
  }
}
