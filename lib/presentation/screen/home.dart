import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:gameshop_deals/model/view_format_enum.dart';
//import 'package:gameshop_deals/provider/display_provider.dart';
import 'package:gameshop_deals/presentation/widgets/appbar.dart';
import 'package:gameshop_deals/presentation/widgets/filter/filter_drawer.dart';
import 'package:gameshop_deals/presentation/widgets/principal_mixin_screen.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/deal_list_view.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

class Home extends ConsumerStatefulWidget {
  final String title;
  final PreferredSizeWidget appBar;
  const Home({Key? key})
      : title = '',
        appBar = const HomeAppBar(),
        super(key: key);

  const Home.Search({Key? key, required this.title})
      : appBar = const SearchAppBar(),
        super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with PrincipalState {
  @override
  Widget build(BuildContext context) {
    //final isPageView =
    //    ref.watch(displayProvider.select((view) => view == ViewFormat.Swipe));

    ref.listen(dealPageProvider(widget.title), (prev, asyncDeals) {
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
            ref.read(dealPageProvider(widget.title).notifier).isLastPage;
        if (noMoreData)
          refreshController.loadNoData();
        else
          refreshController.loadComplete();
      }
    });

    return Scaffold(
      appBar: widget.appBar,
      endDrawer: const FilterDrawer(),
      body: PrimaryScrollController(
        key: PageStorageKey('ListView${widget.title}'),
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
                  top: false,
                  sliver: DealListView(),
                ),
              ],
            ),
            onRefresh: () async {
              refreshController.loadComplete();
              ref.invalidate(dealPageProvider(widget.title));
            },
            onLoading: () async {
              final dealPage =
                  ref.read(dealPageProvider(widget.title).notifier);
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

class ScrollFooter extends LoadIndicator {
  /// load more display style
  final LoadStyle loadStyle;

  const ScrollFooter({Key? key, LoadStyle? loadStyle})
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
      builder: (context, ref, _) {
        final title = ref.watch(titleProvider);
        final deals = ref.watch(dealPageProvider(title));
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
                ref.read(dealPageProvider(title).notifier).retrieveNextPage();
                mode = LoadStatus.loading;
              },
            ),
          ),
        );
      },
    );
  }
}
