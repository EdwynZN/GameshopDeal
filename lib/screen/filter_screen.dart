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
        child: FilterPage(filterProvider)//FilterPage(dealProvider.parameters),
      ) :
      SafeArea(
        child: Material(
          child: FilterPage(filterProvider) //FilterPage(dealProvider.parameters)
        )
      );
  }
}

class FilterPage extends StatelessWidget {
  static final Function deepEq = const DeepCollectionEquality().equals;
  final FilterProvider _filterProvider;

  FilterPage(FilterProvider filter) : _filterProvider = filter.copyWith();

  void _updateParameters(BuildContext context){
    final DealProvider dealProvider = context.read<DealProvider>();
    final bool eq = deepEq(dealProvider.filter.parameters, _filterProvider.parameters);
    if(!eq) {
      dealProvider.filter = _filterProvider;
      dealProvider.requestListOfDeals;
    }
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