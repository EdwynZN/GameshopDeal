import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/view_format_enum.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/compact.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/deal_widget.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/detail_view.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/grid_view.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/single_list_deal.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/display_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DealListView extends ConsumerWidget {
  const DealListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final deals = ref.watch(
      dealPageProvider(title).select((asyncDeals) => asyncDeals.valueOrNull),
    );
    if (deals == null || deals.isEmpty) return const SliverToBoxAdapter();
    final ViewFormat viewFormat = ref.watch(displayProvider);
    return switch (viewFormat) {
        ViewFormat.Grid => SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext _, int index) {
                  return ProviderScope(
                    overrides: [
                      indexDeal.overrideWithValue(index),
                      singleDeal.overrideWithValue(deals[index])
                    ],
                    child: const VerticalGridDeal(),
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
          ),
        ViewFormat.Detail => SliverPadding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          sliver: SliverCrossAxisConstrained(
            maxCrossAxisExtent: 500.0,
            alignment: 0.0,
            child: SliverList(
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
            ),
          ),
        ),
        ViewFormat.Compact => SliverPadding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          sliver: SliverList(
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
          ),
        ),
        ViewFormat.List || ViewFormat.Swipe => SliverListDeal(deals: deals),
      };
  }
}
