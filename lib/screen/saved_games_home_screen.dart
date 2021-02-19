import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/widget/appbar.dart';
import 'package:gameshop_deals/widget/floating_scroll_button.dart';
import 'package:gameshop_deals/widget/principal_screen_mixin.dart';
import 'package:gameshop_deals/widget/view_gamelookup/swipe_page.dart';
import 'package:gameshop_deals/widget/view_gamelookup/scroll_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

class GameHome extends StatefulWidget {
  final String title;
  const GameHome({Key key})
      : title = '',
        super(key: key);

  @override
  _GameHomeState createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> with PrincipalState {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const SavedAppBar(),
        endDrawer: isTablet ? const FilterScreen() : null,
        body: ProviderListener<AsyncValue>(
          onChange: (context, savedGames) {
            if (!mounted) return;
            if (savedGames is AsyncError) {
              if (refreshController.headerStatus != RefreshStatus.failed &&
                  context.read(savedGamesProvider).state.isEmpty) {
                refreshController.refreshFailed();
              }
              refreshController.loadFailed();
              if (ModalRoute.of(context).isCurrent) {
                String message = errorRequestMessage(savedGames);
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
              }
            } else if (savedGames is AsyncData) {
              if (refreshController.isRefresh)
                refreshController.refreshCompleted();
              final noMoreData =
                  context.read(savedGamesPageProvider).isLastPage;
              if (noMoreData)
                refreshController.loadNoData();
              else
                refreshController.loadComplete();
            }
          },
          provider: savedGamesPageProvider.state,
          child: isPageView
              ? PageDeal(controller: pageController)
              : PrimaryScrollController(
                  key: PageStorageKey('GameListView'),
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
                            sliver: const GameListView(),
                          ),
                        ],
                      ),
                      onRefresh: () async {
                        refreshController.loadComplete();
                        context.refresh(savedGamesPageProvider);
                      },
                      onLoading: () async {
                        final gamesPage = context.read(savedGamesPageProvider);
                        if (!gamesPage.isLastPage)
                          await gamesPage.retrieveNextPage();
                        else
                          refreshController.loadNoData();
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
        final S translate = S.of(context);
        final deals = watch(savedGamesPageProvider.state);
        return deals.when(
          data: (cb) {
            if (context.read(savedGamesPageProvider).page == 0 && cb.isEmpty)
              return Center(
                child: Text(
                  translate.no_game_saved,
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            return const SizedBox(height: 4.0);
          },
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
                context.read(savedGamesPageProvider).retrieveNextPage();
                mode = LoadStatus.loading;
              },
            ),
          ),
        );
      },
    );
  }
}
