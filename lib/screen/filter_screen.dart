import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/widget/filter/flag_filter.dart';
import 'package:gameshop_deals/widget/filter/metacritic.dart';
import 'package:gameshop_deals/widget/filter/price_slider.dart';
import 'package:gameshop_deals/widget/filter/sort_by.dart';
import 'package:gameshop_deals/widget/filter/steam_rating.dart';
import 'package:gameshop_deals/widget/filter/stores.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gameshop_deals/widget/filter/order_by.dart';
import 'package:collection/collection.dart';

class FilterScreen extends StatelessWidget{
  final bool isDrawer;

  FilterScreen({this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final DealProvider dealProvider = Provider.of<DealProvider>(context, listen: false);
    final FilterProvider filterProvider = dealProvider.filter;
    return isDrawer ?
      Drawer(
        child: FilterTestPage(filterProvider)//FilterPage(dealProvider.parameters),
      ) :
      SafeArea(
        child: Material(
          child: FilterTestPage(filterProvider) //FilterPage(dealProvider.parameters)
        )
      );
  }
}

class FilterTestPage extends StatelessWidget {
  static final Function deepEq = const DeepCollectionEquality().equals;
  final FilterProvider _filterProvider;

  FilterTestPage(FilterProvider filter) : _filterProvider = filter.copyWith();

  void _updateParameters(BuildContext context){
    final DealProvider dealProvider = context.read<DealProvider>();
    final bool eq = deepEq(dealProvider.filter.parameters, _filterProvider.parameters);
    if(!eq) dealProvider.filter = _filterProvider;
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    final DealProvider dealProvider = Provider.of<DealProvider>(context, listen: false);
    return Provider.value(
      value: _filterProvider,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Theme.of(context).dividerColor
                ),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CloseButton(),
              title: Text('Filters', style: Theme.of(context).textTheme.headline4),
            ),
          ),
          Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(bottom: 19),
                          child: SizedBox(
                              height: 38,
                              child: OrderByWidget()
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 19),
                          child: FlagFilterWidget(),
                        ),
                        Text('Price Range', style: Theme.of(context).textTheme.headline6),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 19),
                            child: PriceSlider()
                        ),
                        Text('Metacritic', style: Theme.of(context).textTheme.headline6),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 19),
                          child: MetacriticFilter(),
                        ),
                        Text('Steam Rating', style: Theme.of(context).textTheme.headline6),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 19),
                          child: SteamRating(),
                        ),
                        Text('Sort By', style: Theme.of(context).textTheme.headline6),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 19),
                          child: SortByWidget(),
                        ),
                        Text('Stores', style: Theme.of(context).textTheme.headline6),
                        FutureProvider<List<Store>>.value(
                          value: dealProvider.requestListOfStores,
                          child: StoreWidget(),
                          catchError: (ctx, object) {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text('No internet'),
                              action: SnackBarAction(
                                  label: 'retry',
                                  onPressed: () => dealProvider.requestListOfStores
                              ),
                            ));
                            return null;
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              )
          ),
          Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 1,
                      color: Theme.of(context).dividerColor
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              width: double.infinity,
              child: OutlineButton(
                onPressed: () => _updateParameters(context),
                child: Text('Apply'),
              )
          ),
        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  final ValueNotifier<int> onSale;
  final ValueNotifier<int> retail;
  final ValueNotifier<int> desc;
  final RangePrice rangePrice;
  final ValueNotifier<int> score;
  final ValueNotifier<int> steamRating;
  final ValueNotifier<String> sortBy;
  final ValueNotifier<int> steamWorks;
  final ValueNotifier<List<int>> storeID;

  FilterPage(Map<String,dynamic> _filter) :
    onSale = ValueNotifier<int>(_filter['onSale'] ?? 0),
    retail = ValueNotifier<int>(_filter['AAA'] ?? 0),
    desc = ValueNotifier<int>(_filter['desc'] ?? 0),
    score = ValueNotifier<int>(_filter['metacritic'] ?? 0),
    steamRating = ValueNotifier<int>(_filter['steamRating'] ?? 0),
    sortBy = ValueNotifier<String>(_filter['sortBy'] ?? dealSortBy[0]),
    rangePrice = RangePrice(
      _filter['lowerPrice'] ?? 0,
      _filter['upperPrice'] ?? 50,
    ),
    steamWorks = ValueNotifier<int>(_filter['steamworks'] ?? 0),
    storeID = ValueNotifier<List<int>>(List<int>.from(_filter['storeID'] ?? <int>[]))
  ;

  void _updateParameters(BuildContext context){
    final DealProvider deal = Provider.of<DealProvider>(context, listen: false);
    deal..sort = sortBy.value..order = desc.value
      ..lowerPrice = rangePrice.start..upperPrice = rangePrice.end..metacritic = score.value
      ..onSale = onSale.value..retail = retail.value..stores = List<int>.from(storeID.value)
      ..steamRating = steamRating.value..steamWorks = steamWorks.value..requestListOfDeals;
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    //final StoreProvider storeProvider = Provider.of<DealProvider>(context, listen: false).storeProvider;
    final DealProvider dealProvider = Provider.of<DealProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor
              ),
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CloseButton(),
            title: Text('Filters', style: Theme.of(context).textTheme.headline4),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: SizedBox(
                        height: 38,
                        child: ValueListenableProvider<int>.value(
                            value: desc,
                            builder: (context, _){
                              final int order = context.watch<int>();
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                      child: FlatButton.icon(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        textColor: order == 0 ? Theme.of(context).accentTextTheme.headline6.color : null,
                                        color: order == 0 ? Theme.of(context).accentColor : null,
                                        shape: Border.all(
                                          color: Theme.of(context).accentColor,
                                          width: 2,
                                        ),
                                        onPressed: () => desc.value = 0,
                                        icon: const Icon(Icons.arrow_downward, size: 20,),
                                        label:  const Flexible(child: FittedBox(child: Text('Ascending (A-Z)'),)),
                                      )
                                  ),
                                  Expanded(
                                      child: FlatButton.icon(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          textColor: order == 1 ? Theme.of(context).accentTextTheme.headline6.color : null,
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
                                          label: const Flexible(child: FittedBox(child: Text('Descending (Z-A)'),))
                                      )
                                  ),
                                ],
                              );
                            },
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: Wrap(
                        spacing: 8,
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          ValueListenableProvider<int>.value(
                            value: onSale,
                            builder: (context, child){
                              final int sale = context.watch<int>();
                              return FilterChip(
                                  label: child,
                                  tooltip: 'On sale',
                                  selected: sale == 1,
                                  onSelected: (value) => onSale.value = value ? 1 : 0
                              );
                            },
                            child: const Text('On sale',),
                          ),
                          ValueListenableProvider<int>.value(
                              value: retail,
                              builder: (context, child){
                                final int onRetail = context.watch<int>();
                                return FilterChip(
                                    label: child,
                                    tooltip: 'Retail discount',
                                    selected: onRetail == 1,
                                    onSelected: (value) => retail.value = value ? 1 : 0
                                );
                              },
                              child: const Text('Retail discount',)
                          ),
                          ValueListenableProvider<int>.value(
                              value: steamWorks,
                              builder: (context, child){
                                final int steam = context.watch<int>();
                                return FilterChip(
                                    label: child,
                                    tooltip: 'SteamWorks',
                                    selected: steam == 1,
                                    onSelected: (value) => steamWorks.value = value ? 1 : 0
                                );
                              },
                              child: const Text('SteamWorks')
                          ),
                        ],
                      ),
                    ),
                    Text('Price Range', style: Theme.of(context).textTheme.headline6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: ChangeNotifierProvider.value(
                        value: rangePrice,
                        child: Consumer<RangePrice>(
                          builder: (context, range, child){
                            return RangeSlider(
                              values: range.rangeValues,
                              onChanged: (newRange) => range.range = newRange,
                              min: 0, max: 50,
                              divisions: 50,
                              labels: RangeLabels(
                                  '\$${range.start}',
                                  '\$${range.end}'
                              ),
                              semanticFormatterCallback: (RangeValues rangeValues) =>
                                '${rangeValues.start.round()} - ${rangeValues.end.round()} dollars'
                            );
                          },
                        ),
                      ),
                    ),
                    Text('Metacritic', style: Theme.of(context).textTheme.headline6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: ValueListenableProvider<int>.value(
                          value: score,
                          child: Consumer<int>(
                            builder: (context, metaScore, child){
                              return Slider.adaptive(
                                value: metaScore.toDouble(),
                                onChanged: (newValue) => score.value = newValue.toInt(),
                                min: 0, max: 95,
                                divisions: 19,
                                label: '${metaScore <= 0 ? ' Any' : metaScore.toString()}',
                              );
                            },
                          )
                      ),
                    ),
                    Text('Steam Rating', style: Theme.of(context).textTheme.headline6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: ValueListenableProvider<int>.value(
                          value: steamRating,
                          child: Consumer<int>(
                            builder: (context, steamScore, child){
                              return Slider.adaptive(
                                value: steamScore <= 40 ? 40 : steamScore.toDouble(),
                                onChanged: (newValue)
                                => steamRating.value = newValue <= 40 ? 0 : newValue.toInt(),
                                min: 40, max: 95,
                                divisions: 11,
                                label: '${steamScore <= 40 ? ' Any' : steamScore.toString()}',
                              );
                            },
                          )
                      ),
                    ),
                    Text('Sort By', style: Theme.of(context).textTheme.headline6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: ValueListenableProvider<String>.value(
                          value: sortBy,
                          child: Consumer<String>(
                            builder: (context, sortOrder, child){
                              return Wrap(
                                spacing: 8,
                                children: <Widget>[
                                  for(String sort in dealSortBy)
                                    ChoiceChip(
                                      tooltip: sort,
                                      /*shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4),
                                        topRight: Radius.circular(4),
                                        topLeft: Radius.circular(4)
                                      )
                                    ),*/
                                      label: Text(sort),
                                      selected: sortOrder == sort,
                                      onSelected: (val) => sortBy.value = sort,
                                      //selectedColor: Theme.of(context).accentColor,
                                    )
                                ],
                              );
                            },
                          )
                      ),
                    ),
                    Text('Stores', style: Theme.of(context).textTheme.headline6),
                    MultiProvider(
                      providers: [
                        FutureProvider<List<Store>>.value(
                          value: dealProvider.requestListOfStores,
                          catchError: (ctx, object) {
                            Scaffold.of(ctx).showSnackBar(SnackBar(
                              content: Text('No internet'),
                              action: SnackBarAction(
                                  label: 'retry',
                                  onPressed: () => dealProvider.requestListOfStores
                              ),
                            ));
                            return null;
                          },
                        ),
                        ValueListenableProvider<List<int>>.value(
                          value: storeID,
                        ),
                        Consumer2<List<int>,List<Store>>(
                          builder: (context, storesSelected, stores, child){
                            if(stores == null) return child;
                            //List<Store> stores1 = List<Store>.from(stores)..retainWhere((element) => element.isActive);
                            return Wrap(
                              spacing: 8,
                              children: <Widget>[
                                ChoiceChip(
                                  selected: storesSelected.isEmpty,
                                  onSelected: (val) => storeID.value = List<int>.from(storesSelected)..clear(),
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
                                      onSelected: (val) => {
                                        if(val) storeID.value = List<int>.from(storesSelected)..add(int.tryParse(store.storeId))
                                        else storeID.value = List<int>.from(storesSelected)..remove(int.tryParse(store.storeId))
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
                        )
                      ],
                      child: OutlineButton(
                        child: Text('No connection'),
                        onPressed: () => dealProvider.requestListOfStores
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          )
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          width: double.infinity,
          child: OutlineButton(
            onPressed: () => _updateParameters(context),
            child: Text('Apply'),
          )
        ),
      ],
    );
  }
}