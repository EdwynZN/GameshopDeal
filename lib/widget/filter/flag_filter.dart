import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/generated/l10n.dart';

final _onSaleProvider = Provider.autoDispose<bool>(
  (ref) {
    final title = ref.watch(titleProvider);
    return ref.watch(filterProviderCopy(title).select((f) => f.onSale));
  },
  name: 'On Sale',
);

final _retailProvider = Provider.autoDispose<bool>(
  (ref) {
    final title = ref.watch(titleProvider);
    return ref.watch(filterProviderCopy(title).select((f) => f.onlyRetail));
  },
  name: 'Only Retail',
);

final _steamWorksProvider = Provider.autoDispose<bool>(
  (ref) {
    final title = ref.watch(titleProvider);
    return ref.watch(filterProviderCopy(title).select((f) => f.steamWorks));
  },
  name: 'SteamWorks',
);

class FlagFilterWidget extends StatelessWidget {
  const FlagFilterWidget({Key? key}) : super(key: key);

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
  const _OnSaleFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final bool sale = ref.watch(_onSaleProvider);
    return FilterChip(
      label: Text(translate.on_sale),
      tooltip: translate.on_sale_tooltip,
      selected: sale,
      onSelected: (value) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(onSale: value);
      },
    );
  }
}

class _RetailWidget extends ConsumerWidget {
  const _RetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final bool retail = ref.watch(_retailProvider);
    return FilterChip(
      label: Text(translate.retail_discount),
      tooltip: translate.retail_discount_tooltip,
      selected: retail,
      onSelected: (value) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(onlyRetail: value);
      },
    );
  }
}

class _SteamWorksWidget extends ConsumerWidget {
  const _SteamWorksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final bool steamWorks = ref.watch(_steamWorksProvider);
    return FilterChip(
      label: Text(translate.steamworks),
      tooltip: translate.steamworks_tooltip,
      selected: steamWorks,
      onSelected: (value) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(steamWorks: value);
      },
    );
  }
}
