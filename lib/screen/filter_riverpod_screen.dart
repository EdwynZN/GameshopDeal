import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/widget/filter/flag_filter.dart';
import 'package:gameshop_deals/widget/filter/metacritic.dart';
import 'package:gameshop_deals/widget/filter/price_slider.dart';
import 'package:gameshop_deals/widget/filter/sort_by.dart';
import 'package:gameshop_deals/widget/filter/steam_rating.dart';
import 'package:gameshop_deals/widget/filter/order_by.dart';
import 'package:gameshop_deals/widget/filter/stores.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/filter_model.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';

class FilterScreen extends StatelessWidget{
  const FilterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDrawer = ModalRoute.of(context).isFirst;
    if(isDrawer) return const Drawer(child: const FilterPage());
    return const SafeArea(
      child: const Material(
        child: const FilterPage() //FilterPage(dealProvider.parameters)
      )
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage();

  @override
  Widget build(BuildContext context) {
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            leading: CloseButton(),
            title: Text('Filters', style: Theme.of(context).textTheme.headline4),
            trailing: IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Restart',
              onPressed: () {
                final StateController<Filter> filterCopy = context.read(filterProviderCopy);
                final StateController<Filter> filter = context.read(filterProvider);
                filterCopy.state = filter.state;
              },
            ),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const SizedBox(
                        height: 38,
                        child: const OrderByWidget()
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const FlagFilterWidget(),
                    ),
                    Text('Price Range', style: Theme.of(context).textTheme.headline6),
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const PriceSlider()
                    ),
                    Text('Metacritic', style: Theme.of(context).textTheme.headline6),
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const MetacriticFilter(),
                    ),
                    Text('Steam Rating', style: Theme.of(context).textTheme.headline6),
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const SteamRating(),
                    ),
                    Text('Sort By', style: Theme.of(context).textTheme.headline6),
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const SortByWidget(),
                    ),
                    Text('Stores', style: Theme.of(context).textTheme.headline6),
                    const StoreWidget()
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
          child: const _ApplyButton()
        ),
      ],
    );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final StateController<Filter> filterCopy = context.read(filterProviderCopy);
        final StateController<Filter> filter = context.read(filterProvider);
        if(filter.state == filterCopy.state) return;
        filter.state = filterCopy.state.copy;
        Navigator.maybePop(context);
      },
      child: Text('Apply'),
    );
  }
}
