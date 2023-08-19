import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/price_widget.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _sortByProvider = Provider.autoDispose<SortBy>((ref) {
  final title = ref.watch(titleProvider);
  return ref.watch(filterProvider(title).select((f) => f.sortBy));
}, name: 'Sort By');

class CompactViewDeal extends ConsumerWidget {
  const CompactViewDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final String title = deal.title;
    final view = ref.watch(_sortByProvider);
    final bool showMetacritic = view == SortBy.Metacritic;
    final bool showRating = view == SortBy.Reviews;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: Divider.createBorderSide(context)),
        ),
        child: ListTile(
          contentPadding: emptyPadding,
          leading: ProviderScope(
            overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
            child: const StoreAvatarLogo(size: 24.0),
          ),
          dense: true,
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.15,
              wordSpacing: -0.25,
              height: 1.25,
            ),
          ),
          trailing: const _PriceWidget(),
        ),
      ),
    );
    /* final int index = ref.watch(indexDeal);
    final view = ref.watch(_sortByProvider);
    final bool showMetacritic = view == SortBy.Metacritic;
    final bool showRating = view == SortBy.Reviews;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: Divider.createBorderSide(context)),
      ),
      child: ListTile(
        leading: ProviderScope(
          overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
          child: const StoreAvatarIcon(),
        ),
        dense: true,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: _Subtitle(
          showRating: showRating,
          showMetacritic: showMetacritic,
          showStore: false,
        ),
        trailing: const PriceWidget(),
        onTap: () =>
            Navigator.of(context).pushNamed(detailRoute, arguments: index),
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (context) => ProviderScope(
              overrides: [singleDeal.overrideWithValue(deal)],
              child: const _BottomSheetButtonsDeal(),
            ),
          );
        },
      ),
    ); */
  }
}

class _PriceWidget extends ConsumerWidget {
  const _PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final bool discount = deal.savings != 0;
    final theme = Theme.of(context);
    final brightness = ThemeData.estimateBrightnessForColor(
        theme.scaffoldBackgroundColor);
    final Color discountColor = brightness == Brightness.light
        ? Colors.green.shade300
        : Colors.greenAccent;
    final Color normalPriceColor =
        brightness == Brightness.light ? Colors.red : Colors.orange;
    final textTheme = theme.textTheme.titleSmall;
    if (discount)
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '\$${deal.normalPrice}',
            style: textTheme?.apply(
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: normalPriceColor,
              fontSizeFactor: 0.75,
              color: normalPriceColor,
            ),
          ),
          gap4,
          Text(
            '\$${deal.salePrice}',
            style: textTheme?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: discountColor,
            ),
          ),
        ],
      );
    return Text(
      '\$${deal.salePrice}',
      style: theme.textTheme.titleMedium,
    );
  }
}
