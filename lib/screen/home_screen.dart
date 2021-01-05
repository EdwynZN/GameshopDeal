import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    show dealsProvider, dealPageProvider, singleDeal;
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/widget/appbar.dart';
import 'package:gameshop_deals/widget/deal_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:gameshop_deals/generated/l10n.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final _scrollControllerProvider = ScopedProvider<ScrollController>(null);
final _animationProvider = ScopedProvider<AnimationController>(null);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..value = 1.0;
    scrollController..addListener(_scrollAnimationListener);
  }

  void _scrollAnimationListener() {
    if ((scrollController?.hasClients ?? false) &&
        !animationController.isAnimating &&
        scrollController.offset > 56.0) {
      switch (scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          if (animationController.isDismissed) animationController.forward();
          animationController.forward();
          break;
        case ScrollDirection.reverse:
          if (animationController.isCompleted) animationController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    }
  }

  bool _scrollListener(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification &&
        scrollNotification.metrics.pixels >=
            (scrollNotification.metrics.maxScrollExtent * 0.9)) {
      if (context.read(dealPageProvider.state).data != null)
        context.read(dealPageProvider).retrievePage();
    }
    return defaultScrollNotificationPredicate(scrollNotification);
  }

  @override
  void dispose() {
    scrollController?.removeListener(_scrollAnimationListener);
    scrollController?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 700;
    return ProviderScope(
      overrides: [
        _animationProvider.overrideWithValue(animationController),
        _scrollControllerProvider.overrideWithValue(scrollController)
      ],
      child: SafeArea(
        child: Scaffold(
          endDrawer: isTablet ? FilterScreen() : null,
          body: ProviderListener<AsyncValue>(
            onChange: (context, deal) {
              if (deal is AsyncError)
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${deal.error}'),
                  ),
                );
            },
            provider: dealPageProvider.state,
            child: RefreshIndicator(
              notificationPredicate: _scrollListener,
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  const HomeAppBar(),
                  const _DealListView(),
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: const EndLinearProgressIndicator(),
                  ),
                ],
              ),
              onRefresh: () async => context.refresh(dealPageProvider),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: const _FAB(),
        ),
      ),
    );
  }
}

class _FAB extends ConsumerWidget {
  const _FAB({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final AnimationController animationController = watch(_animationProvider);
    final ScrollController scrollController = watch(_scrollControllerProvider);
    return ScaleTransition(
      scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 1, curve: Curves.decelerate),
      )),
      child: FloatingActionButton(
        tooltip: S.of(context).up_tooltip,
        mini: true,
        heroTag: 'MenuFAB',
        // onPressed: () => scrollController.animateTo(0.0, curve: Curves.decelerate, duration: const Duration(seconds: 2)),
        // onPressed: () => scrollController.animateTo(0, duration: Duration.zero, curve: Curves.easeOut),
        onPressed: () => scrollController.jumpTo(0.5),
        child: const Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}

class EndLinearProgressIndicator extends ConsumerWidget {
  const EndLinearProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deals = watch(dealPageProvider.state);
    return deals.maybeWhen(
      orElse: () => const Align(
        alignment: Alignment.topCenter,
        child: const LinearProgressIndicator(),
      ),
      error: (e, stack) => Center(
        child: OutlinedButton(
          child: const Text('Error fetching the deals'),
          onPressed: () async =>
              context.read(dealPageProvider).retrievePage(),
        ),
      ),
    );
  }
}

class _DealListView extends ConsumerWidget {
  const _DealListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deals = watch(dealsProvider.state);
    /* return SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      itemCount: deals?.length ?? 0,
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 2.0,
      itemBuilder: (BuildContext _, int index) {
        return ProviderScope(
          overrides: [indexDeal.overrideWithValue(index)],
          child: const TileDeal(),
        );
      },
    ); */

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext _, int index) {
          /*return ProviderScope(
          overrides: [
            singleDeal.overrideWithValue(deals[index]),
            indexDeal.overrideWithValue(index)
          ],
          child: OpenContainer(
            openColor: Theme.of(context).scaffoldBackgroundColor,
            closedColor: Theme.of(context).scaffoldBackgroundColor,
            transitionDuration: const Duration(milliseconds: 500),
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (_, __) => ProviderScope(
              overrides: [
                singleDeal.overrideWithValue(deals[index]),
                indexDeal.overrideWithValue(index)
              ],
              child: const TileTest(),
            ),
            openBuilder: (_, __) => ProviderScope(
              overrides: [
                singleDeal.overrideWithValue(deals[index]),
                indexDeal.overrideWithValue(index)
              ],
              child: const DetailDealScreen(),
            ),
          )
        );
        return OpenContainer(
          openColor: Theme.of(context).scaffoldBackgroundColor,
          closedColor: Theme.of(context).scaffoldBackgroundColor,
          transitionDuration: const Duration(milliseconds: 500),
          transitionType: ContainerTransitionType.fadeThrough,
          closedBuilder: (_, __) => ProviderScope(
            overrides: [
              singleDeal.overrideWithValue(deals[index]),
              indexDeal.overrideWithValue(index)
            ],
            child: const TileTest(),
          ),
          openBuilder: (_, __) => ProviderScope(
            overrides: [
              singleDeal.overrideWithValue(deals[index]),
              indexDeal.overrideWithValue(index)
            ],
            child: const DetailDealScreen(),
          ),
        );*/
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
