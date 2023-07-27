import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/provider/cache_manager_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';
import 'package:gameshop_deals/provider/store_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;

class FilterDrawer extends HookWidget {
  const FilterDrawer();

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController(keys: const []);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final S translate = S.of(context);
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  elevation: 0.0,
                  titleSpacing: 0.0,
                  scrolledUnderElevation: 0.0,
                  centerTitle: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: -0.15,
                    fontWeight: FontWeight.w600,
                  ),
                  leading: const CloseButton(
                    style: ButtonStyle(
                      iconSize: MaterialStatePropertyAll(20.0),
                    ),
                  ),
                  title: Text(
                    translate.filter,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  actionsIconTheme: const IconThemeData(size: 20.0),
                  actions: [
                    const _SaveButton(),
                    const _RestartButton(),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 6.0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: const _OrderWidget(),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 19),
                        child: const _FlagFilterWidget(),
                      ),
                      Text(
                        translate.price_range,
                        style: textTheme.headlineSmall,
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 19),
                        child: const _PriceSlider(),
                      ),
                      Text(
                        'Metacritic',
                        style: textTheme.headlineSmall,
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 19),
                        child: const _MetacriticFilter(),
                      ),
                      Text(
                        translate.steam_rating,
                        style: textTheme.headlineSmall,
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 19),
                        child: const _SteamRating(),
                      ),
                      Text(translate.sortBy, style: textTheme.headlineSmall),
                      const Padding(
                        padding: const EdgeInsets.only(bottom: 19),
                        child: const _SortByWidget(),
                      ),
                      Text(
                        translate.stores,
                        style: textTheme.headlineSmall,
                      ),
                      const _StoreWidget(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: theme.dividerColor),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            width: double.infinity,
            child: const _ApplyButton(),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    //final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.save_outlined),
      tooltip: MaterialLocalizations.of(context).saveButtonLabel,
      onPressed: () async {
        final preferedBox = ref.read(hivePreferencesProvider);
        final StateController<Filter> filterCopy =
            ref.read(filterProviderCopy(title).notifier);
        await preferedBox.put(filterKey, filterCopy.state);
      },
    );
  }
}

class _RestartButton extends ConsumerWidget {
  const _RestartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final S translate = S.of(context);
    final theme = Theme.of(context);
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) return null;
          return theme.colorScheme.onPrimary;
        }),
        textStyle: const MaterialStatePropertyAll(TextStyle(
          fontSize: 12.0,
          letterSpacing: 0.15,
          decoration: TextDecoration.underline,
        )),
      ),
      child: Text(translate.restart_tooltip),
      onPressed: () => ref.refresh(filterProviderCopy(title)),
    );
  }
}

class _ApplyButton extends ConsumerWidget {
  const _ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final S translate = S.of(context);
    return ElevatedButton(
      onPressed: () {
        final StateController<Filter> filterCopy =
            ref.read(filterProviderCopy(title).notifier);
        final StateController<Filter> filter =
            ref.read(filterProvider(title).notifier);
        if (filter.state == filterCopy.state) return;
        filter.state = filterCopy.state.copyWith();
        Navigator.maybePop(context);
      },
      child: Text(translate.apply_filter),
    );
  }
}

/// Order
class _OrderByWidget extends ConsumerWidget {
  const _OrderByWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final bool _isAscendant = ref.watch(
      filterProviderCopy(title).select((f) => f.isAscendant),
    );
    final ThemeData theme = Theme.of(context);
    final Color _accentColor = theme.colorScheme.secondary;
    final Color _accentTextThemeColor = theme.colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: OutlinedButton.icon(
            style: _isAscendant
                ? OutlinedButton.styleFrom(
                    foregroundColor: _accentTextThemeColor,
                    backgroundColor: _accentColor)
                : null,
            onPressed: () {
              if (_isAscendant) return;
              final StateController<Filter> filter =
                  ref.read(filterProviderCopy(title).notifier);
              filter.state = filter.state.copyWith(isAscendant: true);
            },
            icon: const Icon(Icons.arrow_upward, size: 20),
            label: FittedBox(child: Text(translate.ascending)),
          ),
        ),
        Expanded(
          child: OutlinedButton.icon(
            style: !_isAscendant
                ? OutlinedButton.styleFrom(
                    foregroundColor: _accentTextThemeColor,
                    backgroundColor: _accentColor)
                : null,
            onPressed: () {
              if (!_isAscendant) return;
              final StateController<Filter> filter =
                  ref.read(filterProviderCopy(title).notifier);
              filter.state = filter.state.copyWith(isAscendant: false);
            },
            icon: const Icon(Icons.arrow_downward, size: 20),
            label: FittedBox(
              child: Text(translate.descending),
            ),
          ),
        ),
      ],
    );
  }
}

/// Order
class _OrderWidget extends ConsumerWidget {
  const _OrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final bool _isAscendant = ref.watch(
      filterProviderCopy(title).select((f) => f.isAscendant),
    );
    return SegmentedButton<bool>(
      emptySelectionAllowed: false,
      multiSelectionEnabled: false,
      showSelectedIcon: false,
      segments: <ButtonSegment<bool>>[
        ButtonSegment<bool>(
          value: true,
          label: Text(
            translate.ascending,
            style: const TextStyle(fontSize: 12.0),
            maxLines: 1,
          ),
          icon: const Icon(Icons.arrow_upward, size: 20.0),
        ),
        ButtonSegment<bool>(
          value: false,
          label: Text(
            translate.descending, 
            style: const TextStyle(fontSize: 12.0),
            maxLines: 1,
          ),
          icon: const Icon(Icons.arrow_downward, size: 20.0),
        ),
      ],
      selected: <bool>{_isAscendant},
      onSelectionChanged: (newSelection) {
        final StateController<Filter> filter = ref
          .read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(isAscendant: newSelection.first);
      },
    );
  }
}

/// Price
class _PriceSlider extends ConsumerWidget {
  const _PriceSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final RangeValues range = ref.watch(filterProviderCopy(title).select(
      (f) {
        final lower = f.lowerPrice.toDouble();
        final upper = f.upperPrice.toDouble();
        return RangeValues(lower, upper);
      },
    ));
    return RangeSlider(
      values: range,
      onChanged: (newRange) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(
          lowerPrice: newRange.start.round(),
          upperPrice: newRange.end.round(),
        );
      },
      min: 0,
      max: 50,
      divisions: 50,
      labels: RangeLabels('\$${range.start.toInt()}', '\$${range.end.toInt()}'),
      semanticFormatterCallback: translate.dollar_currency,
    );
  }
}

/// Score
class _MetacriticFilter extends ConsumerWidget {
  const _MetacriticFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final double metacritic = ref.watch(
      filterProviderCopy(title).select((f) => f.metacritic.toDouble()),
    );
    return Slider.adaptive(
      value: metacritic,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state.copyWith(metacritic: newValue.toInt());
      },
      min: 0,
      max: 95,
      divisions: 19,
      label:
          '${metacritic <= 0 ? translate.any_metacritic : metacritic.toInt()}',
      semanticFormatterCallback: (value) =>
          '${metacritic <= 0 ? translate.any_metacritic : metacritic.toInt()}',
    );
  }
}

/// Sort
class _SortByWidget extends ConsumerWidget {
  const _SortByWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final SortBy sortOrder =
        ref.watch(filterProviderCopy(title).select((f) => f.sortBy));
    return Wrap(
      spacing: 8,
      children: <Widget>[
        for (SortBy sort in SortBy.values)
          ChoiceChip(
            key: ValueKey<SortBy>(sort),
            tooltip: translate.sort_tooltip(sort),
            label: Text(translate.sort(sort)),
            selected: sortOrder == sort,
            onSelected: (val) {
              final StateController<Filter> filter =
                  ref.read(filterProviderCopy(title).notifier);
              filter.state = filter.state.copyWith(sortBy: sort);
            },
          )
      ],
    );
  }
}

/// Rating
class _SteamRating extends ConsumerWidget {
  const _SteamRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final double score = ref.watch(
      filterProviderCopy(title)
          .select((f) => f.steamRating.clamp(40, 95).toDouble()),
    );
    return Slider.adaptive(
      value: score,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state
            .copyWith(steamRating: newValue <= 40 ? 0 : newValue.toInt());
      },
      min: 40,
      max: 95,
      divisions: 11,
      label: '${score <= 40 ? translate.any_rating : score.toInt()}',
    );
  }
}

/// Flag Filter
typedef _FilterFlags = ({bool onSale, bool onlyRetail, bool steam});

class _FlagFilterWidget extends ConsumerWidget {
  const _FlagFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final _FilterFlags flags = ref.watch(
      filterProviderCopy(title).select<_FilterFlags>(
        (f) =>
            (onSale: f.onSale, onlyRetail: f.onlyRetail, steam: f.steamWorks),
      ),
    );
    return Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      children: <Widget>[
        _FilterChip(
          label: translate.on_sale,
          tooltip: translate.on_sale_tooltip,
          value: flags.onSale,
          onSelected: (value) {
            final StateController<Filter> filter =
                ref.read(filterProviderCopy(title).notifier);
            filter.state = filter.state.copyWith(onSale: value);
          },
        ),
        _FilterChip(
          label: translate.retail_discount,
          tooltip: translate.retail_discount_tooltip,
          value: flags.onlyRetail,
          onSelected: (value) {
            final StateController<Filter> filter =
                ref.read(filterProviderCopy(title).notifier);
            filter.state = filter.state.copyWith(onlyRetail: value);
          },
        ),
        _FilterChip(
          label: translate.steamworks,
          tooltip: translate.steamworks_tooltip,
          value: flags.steam,
          onSelected: (value) {
            final StateController<Filter> filter =
                ref.read(filterProviderCopy(title).notifier);
            filter.state = filter.state.copyWith(steamWorks: value);
          },
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final ValueChanged<bool>? onSelected;
  final bool value;
  final String? tooltip;
  final String label;

  const _FilterChip({
    // ignore: unused_element
    super.key,
    required this.label,
    required this.value,
    this.onSelected,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      tooltip: tooltip,
      selected: value,
      onSelected: onSelected,
    );
  }
}

/// Stores
class _StoreWidget extends ConsumerWidget {
  const _StoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final Set<String> storesSelected =
        ref.watch(filterProviderCopy(title).select((f) => f.storeId));
    final stores = ref.watch(fetchStoresProvider);
    return stores.when(
      loading: () => const Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const LinearProgressIndicator(minHeight: 4),
      ),
      error: (err, stack) => OutlinedButton(
        child: Text('Error fetching the stores'),
        onPressed: () => ref.refresh(fetchStoresProvider),
      ),
      data: (stores) {
        return Wrap(
          spacing: 8,
          children: <Widget>[
            ChoiceChip(
              selected: storesSelected.isEmpty,
              onSelected: (val) {
                final StateController<Filter> filter =
                    ref.read(filterProviderCopy(title).notifier);
                filter.state = filter.state.copyWith(storeId: const <String>{});
              },
              label: Text(translate.all_choice),
              avatar: const Icon(
                Icons.all_inclusive,
                size: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                  topRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              tooltip: translate.all_stores_tooltip,
            ),
            for (Store store in stores)
              ChoiceChip(
                selected: storesSelected.contains(store.storeId),
                onSelected: (val) {
                  final StateController<Filter> filter =
                      ref.read(filterProviderCopy(title).notifier);
                  Set<String> set = Set<String>.from(storesSelected);
                  if (val)
                    set.add(store.storeId);
                  else
                    set.remove(store.storeId);
                  filter.state = filter.state.copyWith(storeId: set);
                },
                label: Text(store.storeName),
                avatar: CachedNetworkImage(
                  cacheManager:
                      ref.watch(cacheManagerProvider(cacheKey: cacheKeyStores)),
                  imageUrl: cheapsharkUrl + store.images.icon,
                  fit: BoxFit.contain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
                tooltip: store.storeName,
              ),
          ],
        );
      },
    );
  }
}
