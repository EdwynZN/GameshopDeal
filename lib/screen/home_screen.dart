import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    show dealPageProvider, dealsProvider;
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/widget/appbar.dart';
import 'package:gameshop_deals/widget/view_deal/scroll_view.dart';
import 'package:gameshop_deals/widget/view_deal/swipe_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;

class MyHomePage extends StatefulWidget {
  final String title;
  final bool search;
  const MyHomePage({Key key})
      : title = '',
        search = false,
        super(key: key);

  const MyHomePage.Search({Key key, this.title})
      : search = true,
        super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* final ScrollController _scrollController = TrackingScrollController(
    keepScrollOffset: false
  ); */
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: false);
  final PageController _pageController = PageController(keepPage: false);
  bool isTablet, isPageView = false;
  ProviderSubscription<DealView> _subscription;
  ProviderContainer _container;
  RefreshController _refreshController = RefreshController();
  S translate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
    isTablet ??= MediaQuery.of(context).size.shortestSide >= 700;
    final container = ProviderScope.containerOf(context);
    if (container != _container) {
      _container = container;
      bool _isPage = _container.read(displayProvider.state) == DealView.Swipe;
      if (_isPage != isPageView) isPageView = _isPage;
      _listen();
    }
  }

  void _listen() {
    _subscription?.close();
    _subscription = null;
    _subscription = _container.listen<DealView>(
      displayProvider.state,
      mayHaveChanged: _mayHaveChanged,
    );
  }

  void _mayHaveChanged(ProviderSubscription<DealView> subscription) {
    if (subscription.flush()) {
      bool _isPage = subscription.read() == DealView.Swipe;
      if (_isPage != isPageView) setState(() => isPageView = _isPage);
    }
  }

  String errorRequestMessage(AsyncError e) {
    if (e.error is DioError) {
      DioError error = e.error as DioError;
      switch (error.type) {
        case DioErrorType.CANCEL:
          return translate.cache_snackbar_cleared;
        case DioErrorType.DEFAULT:
          return 'error.message: ${error.error.osError.message}';
        case DioErrorType.RESPONSE:
          return error.response.statusCode.toString();
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        default:
          return error.message + '${error.type}';
      }
    }
    return e.error;
  }

  @override
  void dispose() {
    _subscription?.close();
    _scrollController?.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.search ? const SearchAppBar() : const HomeAppBar(),
        endDrawer: isTablet ? const FilterScreen() : null,
        body: ProviderListener<AsyncValue>(
          onChange: (context, deal) {
            if (!mounted) return;
            if (deal is AsyncError) {
              if (_refreshController.headerStatus != RefreshStatus.failed &&
                  context.read(dealsProvider(widget.title)).state.isEmpty) {
                _refreshController.refreshFailed();
              }
              _refreshController.loadFailed();
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
              if (_refreshController.isRefresh)
                _refreshController.refreshCompleted();
              final noMoreData =
                  context.read(dealPageProvider(widget.title)).isLastPage;
              if (noMoreData)
                _refreshController.loadNoData();
              else
                _refreshController.loadComplete();
            }
          },
          provider: dealPageProvider(widget.title).state,
          child: isPageView
              ? PageDeal(controller: _pageController)
              : PrimaryScrollController(
                  controller: _scrollController,
                  child: Scrollbar(
                    thickness: 3.0,
                    radius: Radius.circular(3.0),
                    child: SmartRefresher(
                      controller: _refreshController,
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
                        _refreshController.loadComplete();
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
            isPageView ? null : _FAB(controller: _scrollController),
        bottomNavigationBar:
            !isPageView ? null : PageVisualizer(controller: _pageController),
      ),
    );
  }
}

class _PageVisualizer extends StatefulWidget {
  final PageController controller;
  const _PageVisualizer({Key key, this.controller}) : super(key: key);

  @override
  __PageVisualizerState createState() => __PageVisualizerState();
}

class __PageVisualizerState extends State<_PageVisualizer> {
  int _currentPage;

  @override
  void initState() {
    super.initState();
    if ((widget.controller?.hasClients ?? false) &&
        (widget.controller?.page != null ?? false)) {
      _currentPage = widget.controller.page.round() + 1;
    } else {
      _currentPage = widget.controller.initialPage + 1;
    }
    widget.controller?.addListener(_updatePagination);
  }

  @override
  void didUpdateWidget(covariant _PageVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_updatePagination);
      widget.controller?.addListener(_updatePagination);
    }
  }

  void _updatePagination() {
    int currentPage;
    if ((widget.controller?.hasClients ?? false) &&
        (widget.controller?.page != null ?? false)) {
      currentPage = widget.controller.page.round() + 1;
      if (currentPage != _currentPage)
        setState(() => _currentPage = currentPage);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_updatePagination);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Consumer(
          builder: (context, watch, child) {
            final title = watch(titleProvider);
            final maxPage = watch(dealsProvider(title).state).length;
            return Text(
              ' $_currentPage / $maxPage ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1.apply(
                backgroundColor: Theme.of(context).canvasColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FAB extends StatefulWidget {
  final ScrollController controller;
  const _FAB({Key key, this.controller}) : super(key: key);

  @override
  __FABState createState() => __FABState();
}

class __FABState extends State<_FAB> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..value = 1.0;
    positionAnimation = Tween<Offset>(begin: Offset(0, 1.5), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 1, curve: Curves.decelerate),
    ));
    widget.controller?.addListener(_scrollAnimationListener);
  }

  @override
  void didUpdateWidget(covariant _FAB oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_scrollAnimationListener);
      widget.controller?.addListener(_scrollAnimationListener);
    }
  }

  void _scrollAnimationListener() {
    if ((widget.controller?.hasClients ?? false) && !_controller.isAnimating) {
      switch (widget.controller.position.userScrollDirection) {
        case ScrollDirection.forward:
          if (_controller.isDismissed) _controller.forward();
          _controller.forward();
          break;
        case ScrollDirection.reverse:
          if (_controller.isCompleted) _controller.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_scrollAnimationListener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: positionAnimation,
      child: Consumer(
        child: const Icon(Icons.keyboard_arrow_up),
        builder: (context, watch, child) {
          final S translate = S.of(context);
          final title = watch(titleProvider);
          return FloatingActionButton(
            tooltip: translate.up_tooltip,
            heroTag: '${title}_FAB',
            onPressed: () => widget.controller.jumpTo(0.0),
            child: child,
          );
        },
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
