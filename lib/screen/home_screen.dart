import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
  show dealPageProvider, dealsProvider;
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/widget/appbar.dart';
import 'package:gameshop_deals/widget/floating_scroll_button.dart';
import 'package:gameshop_deals/widget/principal_screen_mixin.dart';
import 'package:gameshop_deals/widget/view_deal/scroll_view.dart';
import 'package:gameshop_deals/widget/view_deal/swipe_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

class Home extends StatefulWidget {
  final String title;
  final Widget appBar;
  const Home({Key key}) : title = '', appBar = const HomeAppBar(), super(key: key);

  const Home.Search({Key key, this.title})
    : appBar = const SearchAppBar(),
      super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with PrincipalState {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.appBar,
        endDrawer: isTablet ? const FilterScreen() : null,
        body: ProviderListener<AsyncValue>(
          onChange: (context, deal) {
            if (!mounted) return;
            if (deal is AsyncError) {
              if (refreshController.headerStatus != RefreshStatus.failed &&
                  context.read(dealsProvider(widget.title)).state.isEmpty) {
                refreshController.refreshFailed();
              }
              refreshController.loadFailed();
              if (ModalRoute.of(context).isCurrent) {
                String message = errorRequestMessage(deal);
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
              }
            } else if (deal is AsyncData) {
              if (refreshController.isRefresh)
                refreshController.refreshCompleted();
              final noMoreData =
                  context.read(dealPageProvider(widget.title)).isLastPage;
              if (noMoreData)
                refreshController.loadNoData();
              else
                refreshController.loadComplete();
            }
          },
          provider: dealPageProvider(widget.title).state,
          child: isPageView
              ? PageDeal(controller: pageController)
              : PrimaryScrollController(
                  key: PageStorageKey('ListView'),
                  controller: scrollController,
                  child: Scrollbar(
                    thickness: 3.0,
                    radius: Radius.circular(3.0),
                    child: SmartRefresher(
                      controller: refreshController,
                      primary: true,
                      enablePullDown: true,
                      enablePullUp: true,
                      footer: const ScrollFooter(),
                      child: CustomScrollView(
                        primary: true,
                        slivers: <Widget>[
                          const SliverSafeArea(
                            sliver: const DealListView(),
                          ),
                        ],
                      ),
                      onRefresh: () async {
                        refreshController.loadComplete();
                        context.refresh(dealPageProvider(widget.title));
                      },
                      onLoading: () async {
                        final dealPage =
                            context.read(dealPageProvider(widget.title));
                        if (!dealPage.isLastPage) await dealPage.retrievePage();
                      },
                    ),
                  ),
                ),
        ),
        floatingActionButton:
            isPageView ? null : FAB(controller: scrollController),
        bottomNavigationBar:
            !isPageView ? null : PageVisualizer(controller: pageController),
      ),
    );
  }
}

class ScrollFooter extends LoadIndicator {
  /// load more display style
  final LoadStyle loadStyle;

  const ScrollFooter({Key key, LoadStyle loadStyle})
      : this.loadStyle = loadStyle ?? LoadStyle.ShowWhenLoading,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ScrollFooterState();
}

class _ScrollFooterState extends LoadIndicatorState<ScrollFooter> {
  @override
  Future endLoading() => Future.delayed(const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: buildContent(context, mode),
    );
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus mode) {
    return Consumer(
      builder: (context, watch, _) {
        final title = watch(titleProvider);
        final deals = watch(dealPageProvider(title).state);
        return deals.when(
          data: (_) => const SizedBox(height: 4.0),
          loading: () => const Align(
            alignment: Alignment.topCenter,
            child: const LinearProgressIndicator(),
          ),
          error: (e, stack) => Center(
            child: OutlinedButton(
              child: Text(RefreshLocalizations.of(context)
                  .currentLocalization
                  .loadFailedText),
              onPressed: () async {
                context.read(dealPageProvider(title)).retrievePage();
                mode = LoadStatus.loading;
              },
            ),
          ),
        );
      },
    );
  }
}
