import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/view_format_enum.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/deal_widget.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/display_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class DealListView extends ConsumerWidget {
  const DealListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final deals = ref.watch(dealPageProvider(title)
      .select((asyncDeals) => asyncDeals.valueOrNull),
    );
    final ViewFormat viewFormat = ref.watch(displayProvider);
    if (deals == null || deals.isEmpty) return const SliverToBoxAdapter();
    switch (viewFormat) {
      case ViewFormat.Grid:
        return SliverPadding(
          padding: const EdgeInsets.all(4.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext _, int index) {
                return ProviderScope(
                  overrides: [
                    indexDeal.overrideWithValue(index),
                    singleDeal.overrideWithValue(deals[index])
                  ],
                  child: const GridDeal(),
                );
              },
              childCount: deals.length,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 0.65,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        );
      case ViewFormat.Detail:
        return SliverList(
          //itemExtent: 86.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexDeal.overrideWithValue(index),
                  singleDeal.overrideWithValue(deals[index])
                ],
                child: const DetailedDeal(),
              );
            },
            childCount: deals.length,
          ),
        );
      case ViewFormat.Compact:
        return SliverList(
          //itemExtent: 64.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexDeal.overrideWithValue(index),
                  singleDeal.overrideWithValue(deals[index])
                ],
                child: const CompactDeal(),
              );
            },
            childCount: deals.length,
          ),
        );
      case ViewFormat.List:
      default:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexDeal.overrideWithValue(index),
                  singleDeal.overrideWithValue(deals[index])
                ],
                child: const ListDeal(),
              );
            },
            childCount: deals.length,
          ),
        );
    }
  }
}
