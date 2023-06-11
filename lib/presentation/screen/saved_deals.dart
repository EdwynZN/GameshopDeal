import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/presentation/widgets/principal_mixin_screen.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/deal_list_view.dart';
import 'package:gameshop_deals/provider/saved_deals_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

class SavedGamesPage extends ConsumerStatefulWidget {
  const SavedGamesPage({super.key});

  @override
  _SavedGamesPageState createState() => _SavedGamesPageState();
}

class _SavedGamesPageState extends ConsumerState<SavedGamesPage> with PrincipalState {
  @override
  Widget build(BuildContext context) {
    ref.listen(savedGamesPageProvider, (prev, asyncDeals) {
      if (!mounted) return;
      if (asyncDeals is AsyncError) {
        if (refreshController.headerStatus != RefreshStatus.failed &&
            (!asyncDeals.hasValue || asyncDeals.requireValue.isEmpty)) {
          refreshController.refreshFailed();
        }
        refreshController.loadFailed();
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          String message = errorRequestMessage(asyncDeals as AsyncError);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
        }
      } else if (asyncDeals is AsyncData) {
        if (refreshController.isRefresh) refreshController.refreshCompleted();
        final noMoreData =
            ref.read(savedGamesPageProvider.notifier).isLastPage;
        if (noMoreData)
          refreshController.loadNoData();
        else
          refreshController.loadComplete();
      }
    });

    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text(translate.save_game_title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => ref.invalidate(savedGamesPageProvider),
              icon: const Icon(Icons.refresh_rounded),
            ),
          ),
        ],
      ),
      //endDrawer: isTablet ? const FilterScreen() : null,
      body: PrimaryScrollController(
        key: const PageStorageKey('GameListView'),
        controller: scrollController,
        child: Scrollbar(
          thickness: 3.0,
          radius: Radius.circular(3.0),
          child: SmartRefresher(
            controller: refreshController,
            primary: true,
            enablePullDown: true,
            enablePullUp: true,
            footer: const _ScrollFooter(),
            child: const CustomScrollView(
              primary: true,
              slivers: <Widget>[
                SliverSafeArea(
                  top: false,
                  sliver: DealListView(),
                ),
              ],
            ),
            onRefresh: () async {
              refreshController.loadComplete();
              ref.invalidate(savedGamesProvider);
            },
            onLoading: () async {
              final dealPage = ref.read(savedGamesPageProvider.notifier);
              if (!dealPage.isLastPage) await dealPage.retrieveNextPage();
            },
          ),
        ),
      ),
      /* floatingActionButton:
          isPageView ? null : FAB(controller: scrollController),
      bottomNavigationBar:
          !isPageView ? null : PageVisualizer(controller: pageController), */
    );
  }
}

class _ScrollFooter extends LoadIndicator {
  /// load more display style
  final LoadStyle loadStyle;

  const _ScrollFooter({Key? key, LoadStyle? loadStyle})
      : this.loadStyle = loadStyle ?? LoadStyle.ShowWhenLoading,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ScrollFooterState();
}

class _ScrollFooterState extends LoadIndicatorState<_ScrollFooter> {
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
      builder: (context, ref, _) {
        final deals = ref.watch(savedGamesPageProvider);
        return deals.when(
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          data: (_) => const SizedBox(height: 4.0),
          loading: () => const Align(
            alignment: Alignment.topCenter,
            child: const LinearProgressIndicator(),
          ),
          error: (e, stack) => Center(
            child: OutlinedButton(
              child: Text(RefreshLocalizations.of(context)
                      ?.currentLocalization
                      ?.loadFailedText ??
                  ''),
              onPressed: () async {
                ref.read(savedGamesPageProvider.notifier).retrieveNextPage();
                mode = LoadStatus.loading;
              },
            ),
          ),
        );
      },
    );
  }
}
