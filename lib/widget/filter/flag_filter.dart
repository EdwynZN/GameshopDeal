import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/generated/l10n.dart';

final _onSaleProvider = ScopedProvider<bool>(
  (watch) => watch(filterProviderCopy).state.onSale,
  name: 'On Sale',
);

final _retailProvider = ScopedProvider<bool>(
  (watch) => watch(filterProviderCopy).state.onlyRetail,
  name: 'Only Retail',
);

final _steamWorksProvider = ScopedProvider<bool>(
  (watch) => watch(filterProviderCopy).state.steamWorks,
  name: 'SteamWorks',
);

class FlagFilterWidget extends StatelessWidget {
  const FlagFilterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      children: const <Widget>[
        const _OnSaleFilterWidget(),
        const _RetailWidget(),
        const _SteamWorksWidget(),
      ],
    );
  }
}

class _OnSaleFilterWidget extends ConsumerWidget {
  const _OnSaleFilterWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final bool sale = watch(_onSaleProvider);
    return FilterChip(
      label: Text(translate.on_sale),
      tooltip: translate.on_sale_tooltip,
      selected: sale,
      onSelected: (value) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(onSale: value);
      },
    );
  }
}

class _RetailWidget extends ConsumerWidget {
  const _RetailWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final bool retail = watch(_retailProvider);
    return FilterChip(
      label: Text(translate.retail_discount),
      tooltip: translate.retail_discount_tooltip,
      selected: retail,
      onSelected: (value) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(onlyRetail: value);
      },
    );
  }
}

class _SteamWorksWidget extends ConsumerWidget {
  const _SteamWorksWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final bool steamWorks = watch(_steamWorksProvider);
    return FilterChip(
      label: Text(translate.steamworks),
      tooltip: translate.steamworks_tooltip,
      selected: steamWorks,
      onSelected: (value) {
        final StateController<Filter> filter = context.read(filterProviderCopy);
        filter.state = filter.state.copyWith(steamWorks: value);
      },
    );
  }
}
