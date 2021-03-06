import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/hive_preferences_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/widget/filter/flag_filter.dart';
import 'package:gameshop_deals/widget/filter/metacritic.dart';
import 'package:gameshop_deals/widget/filter/price_slider.dart';
import 'package:gameshop_deals/widget/filter/sort_by.dart';
import 'package:gameshop_deals/widget/filter/steam_rating.dart';
import 'package:gameshop_deals/widget/filter/order_by.dart';
import 'package:gameshop_deals/widget/filter/stores.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDrawer = ModalRoute.of(context).isFirst;
    if (isDrawer) return const Drawer(child: const FilterPage());
    return const SafeArea(child: const Material(child: const FilterPage()));
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage();

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AppBar(
          primary: false,
          titleSpacing: 0.0,
          shape: Border(
            bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
          ),
          leading: const CloseButton(),
          title: Text(translate.filter,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            const _SaveButton(),
            const _RestartButton(),
          ],
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
                        height: 38, child: const OrderByWidget()),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: const FlagFilterWidget(),
                  ),
                  Text(translate.price_range,
                      style: Theme.of(context).textTheme.headline5),
                  const Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: const PriceSlider()),
                  Text('Metacritic',
                      style: Theme.of(context).textTheme.headline5),
                  const Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: const MetacriticFilter(),
                  ),
                  Text(translate.steam_rating,
                      style: Theme.of(context).textTheme.headline5),
                  const Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: const SteamRating(),
                  ),
                  Text(translate.sortBy,
                      style: Theme.of(context).textTheme.headline5),
                  const Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: const SortByWidget(),
                  ),
                  Text(translate.stores,
                      style: Theme.of(context).textTheme.headline5),
                  const StoreWidget()
                ]),
              ),
            ),
          ],
        )),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Theme.of(context).dividerColor),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          width: double.infinity,
          child: const _ApplyButton(),
        ),
      ],
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    //final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.save_outlined),
      tooltip: MaterialLocalizations.of(context).saveButtonLabel,
      onPressed: () async {
        final preferedBox = context.read(hivePreferencesProvider);
        final StateController<Filter> filterCopy =
            context.read(filterProviderCopy(title));
        await preferedBox.put(filterKey, filterCopy.state);
      },
    );
  }
}

class _RestartButton extends ConsumerWidget {
  const _RestartButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.refresh),
      tooltip: translate.restart_tooltip,
      onPressed: () => context.refresh(filterProviderCopy(title)),
    );
  }
}

class _ApplyButton extends ConsumerWidget {
  const _ApplyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    final S translate = S.of(context);
    return ElevatedButton(
      onPressed: () {
        final StateController<Filter> filterCopy =
            context.read(filterProviderCopy(title));
        final StateController<Filter> filter =
            context.read(filterProvider(title));
        if (filter.state == filterCopy.state) return;
        filter.state = filterCopy.state.copyWith();
        Navigator.maybePop(context);
      },
      child: Text(translate.apply_filter),
    );
  }
}