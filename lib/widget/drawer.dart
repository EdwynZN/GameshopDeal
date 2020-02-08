import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FilterDrawer extends StatelessWidget {
  final Map<String,dynamic> _filter;
  final ValueNotifier<int> onSale;
  final ValueNotifier<int> retail;
  final ValueNotifier<int> desc;
  final ValueNotifier<int> lowerPrice;
  final ValueNotifier<int> upperPrice;
  final ValueNotifier<String> sortBy;
  final ValueNotifier<List<int>> storeID;

  FilterDrawer(this._filter) :
    onSale = ValueNotifier<int>(_filter['onSale'] ?? 0),
    retail = ValueNotifier<int>(_filter['AAA'] ?? 0),
    desc = ValueNotifier<int>(_filter['desc'] ?? 0),
    sortBy = ValueNotifier<String>(_filter['sortBy'] ?? dealSortBy[0]),
    lowerPrice = ValueNotifier<int>(_filter['lowerPrice'] ?? 0),
    upperPrice = ValueNotifier<int>(_filter['upperPrice'] ?? 50),
    storeID = ValueNotifier<List<int>>(_filter['storeID'] ?? [])
  ;

  void _updateParameters(BuildContext context){
    final DealProvider deal = Provider.of<DealProvider>(context, listen: false);
    _filter['storeID'].clear();
    deal..sort = sortBy.value..order = desc.value
      ..lowerPrice = lowerPrice.value..upperPrice = upperPrice.value
      ..onSale = onSale.value..retail = retail.value;
    _filter['AAA'] = 1;
    _filter['storeID'].add(1);
    deal..requestListOfDeals;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ValueListenableProvider<int>.value(
      value: onSale,
      child: Consumer<int>(
        builder: (context, sale, child){
          return FilterChip(
            selectedColor: Theme.of(context).accentColor,
            label: Text('On sale',),
            tooltip: 'On sale',
            selected: sale == 1,
            onSelected: (value) => onSale.value = value ? 1 : 0
          );
        },
      )
    );
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Filtering', style: Theme.of(context).textTheme.display1),
                    MaterialButton(
                      height: 34,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      highlightColor: Colors.transparent,
                      textColor: Theme.of(context).accentColor,
                      splashColor: Theme.of(context).selectedRowColor,
                      onPressed: () => _updateParameters(context),
                      child: Text('Apply'),
                    ),
                  ],
                ),
                const Divider(thickness: 1),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 38,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: ValueListenableProvider<int>.value(
                                    value: desc,
                                    child: Consumer<int>(
                                        builder: (context, order, child){
                                          return FlatButton.icon(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            textColor: order == 0 ? Theme.of(context).textTheme.title.color : Theme.of(context).accentColor,
                                            color: order == 0 ? Theme.of(context).accentColor : null,
                                            shape: Border.all(
                                              color: Theme.of(context).accentColor,
                                              width: 2,
                                            ),
                                            onPressed: () => desc.value = 0,
                                            icon: const Icon(Icons.arrow_downward, size: 20,),
                                            label: child,
                                          );
                                        },
                                        child: const Flexible(child: FittedBox(child: Text('Ascending (A-Z)'),))
                                    )
                                ),
                              ),
                              Expanded(
                                child: ValueListenableProvider<int>.value(
                                    value: desc,
                                    child: Consumer<int>(
                                        builder: (context, order, child){
                                          return FlatButton.icon(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            textColor: order == 1 ? Theme.of(context).textTheme.title.color : Theme.of(context).accentColor,
                                            color: order == 1 ? Theme.of(context).accentColor : null,
                                            shape: Border(
                                              bottom: BorderSide(
                                                color: Theme.of(context).accentColor,
                                                width: 2,
                                              ),
                                              top: BorderSide(
                                                color: Theme.of(context).accentColor,
                                                width: 2,
                                              ),
                                              left: BorderSide(
                                                  color: Theme.of(context).accentColor,
                                                  width: 0.0
                                              ),
                                              right: BorderSide(
                                                  color: Theme.of(context).accentColor,
                                                  width: 2.0
                                              ),
                                            ),
                                            onPressed: () => desc.value = 1,
                                            icon: const Icon(Icons.arrow_upward, size: 20),
                                            label: child,
                                          );
                                        },
                                        child: const Flexible(child: FittedBox(child: Text('Descending (Z-A)'),))
                                    )
                                ),
                              ),
                            ],
                          )
                        ),
                        const SizedBox(height: 19,),
                        Wrap(
                          spacing: 8, runSpacing: 4,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            ValueListenableProvider<int>.value(
                                value: onSale,
                                child: Consumer<int>(
                                  builder: (context, sale, child){
                                    return FilterChip(
                                        selectedColor: Theme.of(context).accentColor,
                                        label: child,
                                        tooltip: 'On sale',
                                        selected: sale == 1,
                                        onSelected: (value) => onSale.value = value ? 1 : 0
                                    );
                                  },
                                  child: const Text('On sale',),
                                )
                            ),
                            ValueListenableProvider<int>.value(
                              value: retail,
                              child: Consumer<int>(
                                builder: (context, onRetail, child){
                                  return FilterChip(
                                    selectedColor: Theme.of(context).accentColor,
                                    label: child,
                                    tooltip: 'Retail discount',
                                    selected: onRetail == 1,
                                    onSelected: (value) => retail.value = value ? 1 : 0
                                  );
                                },
                                child: const Text('Retail discount',)
                              )
                            ),
                          ],
                        ),
                        const Divider(thickness: 1, height: 38,),
                        SizedBox(
                          height: 20,
                          child: Center(
                            child: Text('Price Range', style: Theme.of(context).textTheme.body2),
                          )
                        ),
                        StatefulBuilder(
                          builder: (ctx, setState){
                            final RangeValues rangeValues =
                              RangeValues(_filter['lowerPrice'].toDouble(),
                                _filter['upperPrice'].toDouble());
                            return RangeSlider(
                              values: rangeValues,
                              onChanged: (newRange) => setState(() {
                                _filter['lowerPrice'] = newRange.start.toInt();
                                _filter['upperPrice'] = newRange.end.toInt();
                              }),
                              min: 0, max: 50,
                              divisions: 50,
                              labels: RangeLabels(
                                '\$${_filter['lowerPrice']}',
                                '\$${_filter['upperPrice']}'
                              ),
                            );
                          }
                        ),
                        const Divider(thickness: 1, height: 38,),
                        SizedBox(
                          height: 36,
                          child: Text('Sort By', style: Theme.of(context).textTheme.title),
                        ),
                        Wrap(
                          runSpacing: 4,
                          spacing: 8,
                          children: <Widget>[
                            for(String sort in dealSortBy)
                              ValueListenableProvider<String>.value(
                                  value: sortBy,
                                  child: Consumer<String>(
                                    builder: (context, sortOrder, child){
                                      return ChoiceChip(
                                        tooltip: sort,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                topLeft: Radius.circular(4)
                                            )
                                        ),
                                        label: Text(sort),
                                        selected: sortOrder == sort,
                                        onSelected: (val) => sortBy.value = sort,
                                        selectedColor: Theme.of(context).accentColor,
                                      );
                                    },
                                  )
                              ),
                          ],
                        ),
                        const Divider(thickness: 1, height: 38,),
                        SizedBox(
                          height: 36,
                          child: Text('Stores', style: Theme.of(context).textTheme.title),
                        ),
                        FutureProvider<List<Store>>.value(
                          value: Provider.of<StoreProvider>(context, listen: false).requestListOfStores,
                          catchError: (ctx, object) {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text('No internet'),
                              action: SnackBarAction(
                                  label: 'retry',
                                  onPressed: () => Provider.of<StoreProvider>(context, listen: false).requestListOfStores
                              ),
                            ));
                            return null;
                          },
                          child: ValueListenableProvider<List<int>>.value(
                            value: storeID,
                            child: Consumer2<List<int>, List<Store>>(
                              builder: (context, storesSelected, stores, child){
                                if(stores == null) return child;
                                return Wrap(
                                  runSpacing: 4,
                                  spacing: 8,
                                  children: <Widget>[
                                    ChoiceChip(
                                      selected: storesSelected.isEmpty,
                                      onSelected: (val) => storeID.value = List.from(storesSelected)..clear(),
                                      label: Text('All'),
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
                                      if(store.isActive == 1)
                                        ChoiceChip(
                                          selected: storesSelected.contains(int.tryParse(store.storeId)),
                                          onSelected: (val) => {
                                            if(val) storeID.value = List.from(storesSelected)..add(int.tryParse(store.storeId))
                                            else storeID.value = List.from(storesSelected)..remove(int.tryParse(store.storeId))
                                          },
                                          label: Text(store.storeName),
                                          avatar: CachedNetworkImage(
                                            imageUrl: 'https://www.cheapshark.com${store.images.icon}',
                                            fit: BoxFit.contain, height: 20, width: 20,
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
                              child: OutlineButton(
                                  child: Text('No connection'),
                                  onPressed: () => Provider.of<StoreProvider>(context, listen: false).requestListOfStores
                              ),
                            )
                          )
                              /*
                          Consumer<List<Store>>(
                            builder: (context, stores, child){
                              if(stores == null) return child;
                              return ValueListenableProvider<List<int>>.value(
                                value: storeID,
                                child: Consumer2<List<int>, List<Store>>(
                                  builder: (context, storesSelected, stores, child){
                                    if(stores == null) return child;
                                    return Wrap(
                                      runSpacing: 4,
                                      spacing: 8,
                                      children: <Widget>[
                                        ChoiceChip(
                                          selected: storesSelected.isEmpty,
                                          onSelected: (val) => storeID.value.clear(),
                                          label: Text('All'),
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
                                          if(store.isActive == 1)
                                            ChoiceChip(
                                              selected: storesSelected.contains(int.tryParse(store.storeId)),
                                              onSelected: (val) => {
                                                if(val) storeID.value.add(int.tryParse(store.storeId))
                                                else storeID.value.remove(int.tryParse(store.storeId))
                                              },
                                              label: Text(store.storeName),
                                              avatar: CachedNetworkImage(
                                                imageUrl: 'https://www.cheapshark.com${store.images.icon}',
                                                fit: BoxFit.contain, height: 20, width: 20,
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
                                  child: OutlineButton(
                                      child: Text('No connection'),
                                      onPressed: () => Provider.of<StoreProvider>(context, listen: false).requestListOfStores
                                  ),
                                )
                              );
                              return StatefulBuilder(
                                builder: (ctx, setState){
                                  return Wrap(
                                    runSpacing: 4,
                                    spacing: 8,
                                    children: <Widget>[
                                      ChoiceChip(
                                        selected: _filter['storeID'].isEmpty,
                                        onSelected: (val) => setState(() => _filter['storeID'].clear()),
                                        label: Text('All'),
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
                                        if(store.isActive == 1)
                                          ChoiceChip(
                                            selected: _filter['storeID'].contains(int.tryParse(store.storeId)),
                                            onSelected: (val) => setState(() {
                                              if(val) _filter['storeID'].add(int.tryParse(store.storeId));
                                              else _filter['storeID'].remove(int.tryParse(store.storeId));
                                            }),
                                            label: Text(store.storeName),
                                            avatar: CachedNetworkImage(
                                              imageUrl: 'https://www.cheapshark.com${store.images.icon}',
                                              fit: BoxFit.contain, height: 20, width: 20,
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
                              );
                            },
                            child: OutlineButton(
                              child: Text('No connection'),
                              onPressed: () => Provider.of<StoreProvider>(context, listen: false).requestListOfStores
                            ),
                          ),
                          */
                        ),
                        /*
                        FutureBuilder(
                          future: listOfStores,
                          builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot){
                            print('rebuild');
                            if(snapshot.hasData)
                              return StatefulBuilder(
                                  builder: (ctx, setState){
                                    return Wrap(
                                      //alignment: WrapAlignment.spaceBetween,
                                      runSpacing: 4,
                                      spacing: 8,
                                      children: <Widget>[
                                        ChoiceChip(
                                          selected: param['storeID'].isEmpty,
                                          onSelected: (val) => setState(() => param['storeID'].clear()),
                                          label: Text('All'),
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
                                        for(Store store in snapshot.data)
                                          if(store.isActive == 1)
                                            ChoiceChip(
                                              selected: param['storeID'].contains(int.tryParse(store.storeId)),
                                              onSelected: (val) => setState(() {
                                                if(val) param['storeID'].add(int.tryParse(store.storeId));
                                                else param['storeID'].remove(int.tryParse(store.storeId));
                                              }),
                                              label: Text(store.storeName),
                                              avatar: CachedNetworkImage(
                                                imageUrl: 'https://www.cheapshark.com${store.images.icon}',
                                                fit: BoxFit.contain, height: 20, width: 20,
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
                              );
                            else return const SizedBox();
                          }
                        ),
                        */
                      ]),
                    ),
                  ),
                ],
              )
            )
          ),
        ],
      )
    );
  }
}