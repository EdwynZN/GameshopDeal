import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter_model.dart';

final _onSaleProvider = Provider.autoDispose((ref) =>
  ref.watch(filterProviderCopy).state.onSale,
  name: 'On Sale'
);

final _retailProvider = Provider.autoDispose((ref) =>
  ref.watch(filterProviderCopy).state.onlyRetail,
  name: 'Only Retail'
);

final _steamWorksProvider = Provider.autoDispose((ref) =>
  ref.watch(filterProviderCopy).state.steamWorks,
  name: 'SteamWorks'
);

class FlagFilterWidget extends StatelessWidget {
  const FlagFilterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      children: <Widget>[
        const _OnSaleFilterWidget(),
        _RetailWidget(),
        _SteamWorksWidget(),
      ],
    );
  }
}

class _OnSaleFilterWidget extends ConsumerWidget{
  const _OnSaleFilterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool sale = watch(_onSaleProvider);
    return FilterChip(
      label: const Text('On sale'),
      tooltip: 'On sale',
      selected: sale,
      onSelected: (value) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(onSale: value);
      },
    );
  }
}

class _RetailWidget extends ConsumerWidget{
  const _RetailWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool retail = watch(_retailProvider);
    return FilterChip(
      label: const Text('Retail discount'),
      tooltip: 'Retail discount',
      selected: retail,
      onSelected: (value) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(onlyRetail: value);
      },
    );
  }
}

class _SteamWorksWidget extends ConsumerWidget{
  const _SteamWorksWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool steamWorks = watch(_steamWorksProvider);
    return FilterChip(
      label: const Text('SteamWorks'),
      tooltip: 'SteamWorks',
      selected: steamWorks,
      onSelected: (value) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(steamWorks: value);
      },
    );
  }
}
