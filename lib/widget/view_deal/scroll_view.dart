import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
  show dealsProvider, singleDeal;
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/widget/deal_widget.dart';

class DealListView extends ConsumerWidget {
  const DealListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    final deals = watch(dealsProvider(title).state);
    final DealView view = watch(displayProvider.state);
    if (deals.isEmpty) return const SliverToBoxAdapter();
    switch (view) {
      case DealView.Grid:
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
      case DealView.Detail:
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
            childCount: deals?.length ?? 0,
          ),
        );
      case DealView.Compact:
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
            childCount: deals?.length ?? 0,
          ),
        );
      case DealView.List:
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
            childCount: deals?.length ?? 0,
          ),
        );
    }
  }
}
