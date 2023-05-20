import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    show dealsProvider, singleDeal;
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/widget/deal_widget.dart';
import 'package:gameshop_deals/model/view_enum.dart' as viewEnum;

class DealListView extends ConsumerWidget {
  const DealListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final deals = ref.watch(dealsProvider(title));
    final viewEnum.View view = ref.watch(displayProvider);
    if (deals.isEmpty) return const SliverToBoxAdapter();
    switch (view) {
      case viewEnum.View.Grid:
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
      case viewEnum.View.Detail:
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
      case viewEnum.View.Compact:
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
      case viewEnum.View.List:
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
