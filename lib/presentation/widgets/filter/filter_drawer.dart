import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/provider/cache_manager_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';
import 'package:gameshop_deals/provider/store_provider.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:flutter_hooks/flutter_hooks.dart' hide Store;
import 'package:sliver_tools/sliver_tools.dart';

final _filterInternalProvider =
    StateProvider.autoDispose.family<Filter, String>(
  (ref, title) => ref.watch(filterProvider(title).notifier).state.copyWith(),
  name: 'FilterScreen',
);

class FilterDrawer extends HookWidget {
  const FilterDrawer();

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController(keys: const []);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final S translate = S.of(context);
    final titleTheme = textTheme.titleMedium;
    return PrimaryScrollController.none(
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  const SliverPinnedHeader(child: _TitleBar()),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const _OrderWidget(),
                        gap16,
                        Text(translate.filter, style: titleTheme),
                        gap4,
                        Consumer(
                          builder: (context, ref, child) {
                            final title = ref.watch(titleProvider);
                            final bool onSale = ref.watch(
                              _filterInternalProvider(title).select<bool>(
                                (f) => f.onSale,
                              ),
                            );
                            return _FilterListTile(
                              title: translate.on_sale,
                              value: onSale,
                              onChanged: (value) {
                                if (value == null) return;
                                final StateController<Filter> filter = ref.read(
                                    _filterInternalProvider(title).notifier);
                                filter.state =
                                    filter.state.copyWith(onSale: value);
                              },
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final title = ref.watch(titleProvider);
                            final bool onlyRetail = ref.watch(
                              _filterInternalProvider(title).select<bool>(
                                (f) => f.onlyRetail,
                              ),
                            );
                            return _FilterListTile(
                              title: translate.retail_discount,
                              value: onlyRetail,
                              onChanged: (value) {
                                if (value == null) return;
                                final StateController<Filter> filter = ref.read(
                                    _filterInternalProvider(title).notifier);
                                filter.state =
                                    filter.state.copyWith(onlyRetail: value);
                              },
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final title = ref.watch(titleProvider);
                            final bool steamWorks = ref.watch(
                              _filterInternalProvider(title).select<bool>(
                                (f) => f.steamWorks,
                              ),
                            );
                            return _FilterListTile(
                              title: translate.steamworks,
                              value: steamWorks,
                              onChanged: (value) {
                                if (value == null) return;
                                final StateController<Filter> filter = ref.read(
                                    _filterInternalProvider(title).notifier);
                                filter.state =
                                    filter.state.copyWith(steamWorks: value);
                              },
                            );
                          },
                        ),
                        gap16,
                        Text(translate.price_range, style: titleTheme),
                        gap4,
                        const _PriceSlider(),
                        gap16,
                        Text('Metacritic', style: titleTheme),
                        gap4,
                        const _MetacriticFilter(),
                        gap16,
                        Text(translate.steam_rating, style: titleTheme),
                        gap4,
                        const _SteamRating(),
                        gap16,
                        Text(translate.sortBy, style: titleTheme),
                        gap4,
                        const _SortByWidget(),
                        gap16,
                        Text(translate.stores, style: titleTheme),
                        gap4,
                        const _StoreWidget(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              margin: emptyPadding,
              elevation: 12.0,
              shadowColor: Colors.transparent,
              child: SafeArea(
                top: false,
                maintainBottomViewPadding: false,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: const Center(child: _ApplyButton()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SystemUiOverlayStyle _systemOverlayStyleForBrightness(Brightness brightness,
    [Color? backgroundColor]) {
  final SystemUiOverlayStyle style = brightness == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;
  // For backward compatibility, create an overlay style without system navigation bar settings.
  return SystemUiOverlayStyle(
    statusBarColor: backgroundColor,
    statusBarBrightness: style.statusBarBrightness,
    statusBarIconBrightness: style.statusBarIconBrightness,
    systemStatusBarContrastEnforced: style.systemStatusBarContrastEnforced,
  );
}

class _TitleBar extends StatelessWidget {
  // ignore: unused_element
  const _TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor =
        theme.appBarTheme.backgroundColor ?? theme.primaryColor;
    final Widget appbar = SafeArea(
      bottom: false,
      child: Container(
        height: 56.0,
        color: backgroundColor,
        child: IconTheme.merge(
          data: theme.appBarTheme.iconTheme ?? const IconThemeData.fallback(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: NavigationToolbar(
              leading: const CloseButton(
                style: ButtonStyle(
                  iconSize: MaterialStatePropertyAll(24.0),
                ),
              ),
              centerMiddle: true,
              middleSpacing: 56.0,
              middle: Text(
                S.of(context).filter,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.appBarTheme.titleTextStyle ??
                    theme.textTheme.titleLarge
                        ?.copyWith(color: theme.appBarTheme.foregroundColor),
              ),
            ),
          ),
        ),
      ),
    );

    final SystemUiOverlayStyle overlayStyle =
        theme.appBarTheme.systemOverlayStyle ??
            _systemOverlayStyleForBrightness(
              ThemeData.estimateBrightnessForColor(backgroundColor),
              // Make the status bar transparent for M3 so the elevation overlay
              // color is picked up by the statusbar.
              theme.useMaterial3 ? const Color(0x00000000) : null,
            );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(color: backgroundColor, child: appbar),
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
            ref.read(_filterInternalProvider(title).notifier);
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
        overlayColor: MaterialStatePropertyAll(
          theme.colorScheme.primaryContainer.withOpacity(0.24),
        ),
      ),
      child: Text(translate.restart_tooltip),
      onPressed: () => ref.refresh(_filterInternalProvider(title)),
    );
  }
}

class _ApplyButton extends ConsumerWidget {
  const _ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final S translate = S.of(context);
    return FilledButton(
      onPressed: () {
        final StateController<Filter> filterCopy =
            ref.read(_filterInternalProvider(title).notifier);
        final StateController<Filter> filter =
            ref.read(filterProvider(title).notifier);
        if (filter.state != filterCopy.state) {
          filter.state = filterCopy.state.copyWith();
        }
        Navigator.maybePop(context);
      },
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(280.0, 44.0)),
      ),
      child: Text(translate.apply_filter),
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
      _filterInternalProvider(title).select((f) => f.isAscendant),
    );
    return SegmentedButton<bool>(
      emptySelectionAllowed: false,
      multiSelectionEnabled: false,
      showSelectedIcon: false,
      style: const ButtonStyle(
        visualDensity: VisualDensity(vertical: -0.5),
        tapTargetSize: MaterialTapTargetSize.padded,
        textStyle: MaterialStatePropertyAll(
          TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
      ),
      segments: <ButtonSegment<bool>>[
        ButtonSegment<bool>(
          value: true,
          label: Text(translate.ascending,maxLines: 1),
          icon: const Icon(Icons.arrow_upward, size: 24.0),
        ),
        ButtonSegment<bool>(
          value: false,
          label: Text(translate.descending, maxLines: 1),
          icon: const Icon(Icons.arrow_downward, size: 24.0),
        ),
      ],
      selected: <bool>{_isAscendant},
      onSelectionChanged: (newSelection) {
        final StateController<Filter> filter =
            ref.read(_filterInternalProvider(title).notifier);
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
    final RangeValues range = ref.watch(_filterInternalProvider(title).select(
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
            ref.read(_filterInternalProvider(title).notifier);
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
      _filterInternalProvider(title).select((f) => f.metacritic.toDouble()),
    );
    return Slider.adaptive(
      value: metacritic,
      thumbColor: Theme.of(context).primaryColor,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            ref.read(_filterInternalProvider(title).notifier);
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
        ref.watch(_filterInternalProvider(title).select((f) => f.sortBy));
    return Wrap(
      spacing: 8,
      runSpacing: 2.0,
      children: <Widget>[
        for (SortBy sort in SortBy.values)
          ChoiceChip(
            key: ValueKey<SortBy>(sort),
            tooltip: translate.sort_tooltip(sort),
            label: Text(translate.sort(sort)),
            selected: sortOrder == sort,
            onSelected: (val) {
              final StateController<Filter> filter =
                  ref.read(_filterInternalProvider(title).notifier);
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
      _filterInternalProvider(title)
          .select((f) => f.steamRating.clamp(40, 95).toDouble()),
    );
    return Slider.adaptive(
      thumbColor: Theme.of(context).primaryColor,
      value: score,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            ref.read(_filterInternalProvider(title).notifier);
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

class _FilterListTile extends StatelessWidget {
  final ValueChanged<bool?>? onChanged;
  final bool value;
  final String title;

  const _FilterListTile({
    // ignore: unused_element
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      visualDensity: const VisualDensity(vertical: -1.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      checkboxSemanticLabel: title,
      contentPadding: const EdgeInsets.only(left: 24.0, right: 16.0),
      checkboxShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      title: Text(title),
      value: value,
      onChanged: onChanged,
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
        ref.watch(_filterInternalProvider(title).select((f) => f.storeId));
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
        final avatarColor = Theme.of(context).colorScheme.onSecondaryContainer;
        return Wrap(
          spacing: 8,
          children: <Widget>[
            FilterChip(
              showCheckmark: false,
              selected: storesSelected.isEmpty,
              onSelected: (val) {
                final StateController<Filter> filter =
                    ref.read(_filterInternalProvider(title).notifier);
                filter.state = filter.state.copyWith(storeId: const <String>{});
              },
              label: Text(translate.all_choice),
              avatar: Icon(Icons.all_inclusive, size: 20, color: avatarColor),
              tooltip: translate.all_stores_tooltip,
            ),
            for (Store store in stores)
              FilterChip(
                showCheckmark: false,
                selected: storesSelected.contains(store.storeId),
                onSelected: (val) {
                  final StateController<Filter> filter =
                      ref.read(_filterInternalProvider(title).notifier);
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
                tooltip: store.storeName,
              ),
          ],
        );
      },
    );
  }
}
