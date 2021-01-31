import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/widget/deal_widget.dart';
import 'package:gameshop_deals/widget/store_deal_widget.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    hide storesProvider, singleStoreProvider;
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/widget/view_deal/swipe_page.dart';

class DetailDealScreen extends StatelessWidget {
  const DetailDealScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (ctx, watch, _) {
          final String title = watch(titleProvider);
          final int childCount = watch(dealsProvider(title).state).length;
          final int indexOffset = watch(indexDeal);
          return _DetailPageView(
            offset: indexOffset,
            childCount: childCount,
            title: title,
          );
        },
      ),
    );
  }
}

class _DetailPageView extends StatefulWidget {
  final int offset;
  final int childCount;
  final String title;

  const _DetailPageView({Key key, this.offset, this.childCount, this.title})
      : super(key: key);

  @override
  __DetailPageViewState createState() => __DetailPageViewState();
}

class __DetailPageViewState extends State<_DetailPageView> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.offset);
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageDeal(
        controller: pageController,
      ),
      bottomNavigationBar: null,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                tooltip: 'First',
                heroTag: 'First',
                child: const Icon(Icons.arrow_back),
                onPressed: () => pageController.hasClients
                    ? pageController.jumpToPage(0)
                    : null),
            FloatingActionButton(
                tooltip: 'Last',
                heroTag: 'Last',
                child: const RotatedBox(
                    quarterTurns: 2, child: const Icon(Icons.arrow_back)),
                onPressed: () => pageController.hasClients
                    ? pageController.jumpToPage(widget.childCount - 1)
                    : null),
          ],
        ),
      ),
    );
    return Scaffold(
      body: PageView.custom(
        controller: pageController,
        onPageChanged: (index) {
          final dealPage = context.read(dealPageProvider(widget.title));
          final int childCount =
              context.read(dealsProvider(widget.title).state).length;

          if (!dealPage.isLastPage && index <= (childCount - 1)) {
            dealPage.retrievePage();
            print('refresh');
          }
        },
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            final int childCount =
                context.read(dealsProvider(widget.title).state).length;
            if ((childCount == index || childCount == 0) &&
                !context.read(dealPageProvider(widget.title)).isLastPage)
              return const EndLinearProgressIndicator();
            else if (index >= childCount) return null;
            return ProviderScope(
              overrides: [
                singleDeal.overrideAs((watch) {
                  final title = watch(titleProvider);
                  return watch(dealsProvider(title).state)[index];
                })
              ],
              child: const _CustomView(),
            );
          },
          //childCount: widget.childCount,
          // findChildIndexCallback: (_) {
          //   return index;
          // }
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
                tooltip: 'First',
                heroTag: 'First',
                child: const Icon(Icons.arrow_back),
                onPressed: () => pageController.hasClients
                    ? pageController.jumpToPage(0)
                    : null),
            FloatingActionButton(
                tooltip: 'Last',
                heroTag: 'Last',
                child: const RotatedBox(
                    quarterTurns: 2, child: const Icon(Icons.arrow_back)),
                onPressed: () => pageController.hasClients
                    ? pageController.jumpToPage(widget.childCount - 1)
                    : null),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationPage extends ConsumerWidget {
  const BottomNavigationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Material(
      type: MaterialType.canvas,
      
    );
  }
}

class EndLinearProgressIndicator extends ConsumerWidget {
  const EndLinearProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    final deals = watch(dealPageProvider(title).state);
    return deals.when(
      data: (_) => Center(
        heightFactor: 3.0,
        child: const Text('No more games to show'),
      ),
      loading: () => const Align(
        alignment: Alignment.topCenter,
        child: const LinearProgressIndicator(),
      ),
      error: (e, stack) => Center(
        heightFactor: 3.0,
        child: OutlinedButton(
          child: const Text('Error fetching the deals'),
          onPressed: () async =>
              context.read(dealPageProvider(title)).retrievePage(),
        ),
      ),
    );
  }
}

class _CustomView extends StatefulWidget {
  const _CustomView({Key key}) : super(key: key);

  @override
  __CustomViewState createState() => __CustomViewState();
}

class __CustomViewState extends State<_CustomView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        const SliverPadding(
          padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 0.0),
          sliver: const SliverToBoxAdapter(
            child: const ListDeal(showDeal: false),
          ),
        ),
        /* const SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: const SliverToBoxAdapter(
              child: const ButtonsDeal(),
            )), */
        const SliverDivider(),
        const _DealListWidget(),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: const SizedBox(height: 80.0),
        )
      ],
    );
  }
}

class SliverDivider extends StatelessWidget {
  const SliverDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Divider());
  }
}

class _DealListWidget extends ConsumerWidget {
  const _DealListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 700 ||
        watch(displayProvider.state) == DealView.Grid;
    final String gameId = watch(singleDeal).gameId;
    final dealList = watch(dealsOfGameProvider(gameId));
    return dealList.when(
      loading: () =>
          const SliverToBoxAdapter(child: const LinearProgressIndicator()),
      error: (_, __) => SliverToBoxAdapter(
        child: Center(
          child: OutlinedButton(
            child: Text('Error fetching the deals'),
            onPressed: () => context.refresh(gameDealLookupProvider(gameId)),
          ),
        ),
      ),
      data: (deals) {
        if (isTablet)
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 175.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.25,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => ProviderScope(
                  overrides: [singleDeal.overrideWithValue(deals[index])],
                  child: const StoreDealGrid(),
                ),
                semanticIndexOffset: 1,
                childCount: deals.length ?? 0,
              ),
            ),
          );
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ProviderScope(
              overrides: [
                /* _detailProvider.overrideWithValue(
                    DetailDeal(index: index, id: gameId)), */
                singleDeal.overrideWithValue(deals[index])
              ],
              child: const StoreDealTile(),
            ),
            childCount: deals.length ?? 0,
          ),
        );
      },
    );
  }
}
