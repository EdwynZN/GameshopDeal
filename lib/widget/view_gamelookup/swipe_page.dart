import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart';
import 'package:gameshop_deals/widget/display_deal/saved_deal_button.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:gameshop_deals/widget/display_gamelookup/cheapest_ever.dart';
import 'package:gameshop_deals/widget/gamelookup_widget.dart';
import 'package:gameshop_deals/widget/store_deal_widget.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    hide storesProvider, singleStoreProvider;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageDeal extends ConsumerWidget {
  final PageController? controller;
  const PageDeal({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int childCount = ref.watch(gameKeysProvider).length;
    return PageView.custom(
      controller: controller,
      onPageChanged: (index) {
        final gamePage = ref.read(savedGamesPageProvider);
        if (!gamePage.isLastPage && index == (childCount - 1)) {
          gamePage.retrieveNextPage();
        }
      },
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final pageProvider = ref.read(savedGamesPageProvider);
          if (childCount == index &&
              (!pageProvider.isLastPage ||
                  pageProvider.page == 0 && childCount == 0))
            return const _EndLinearProgressIndicator();
          else if (index >= childCount) return null;
          return ProviderScope(
            overrides: [
              singleGameLookup.overrideAs((watch) {
                final key = ref.watch(gameKeysProvider);
                return ref.watch(savedGamesProvider.state)[key[index]];
              }),
              indexGameLookup.overrideWithValue(index),
            ],
            child: const _SwipePage(),
          );
        },
      ),
    );
  }
}

class _SwipePage extends StatelessWidget {
  const _SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: [
        const SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: const SliverToBoxAdapter(
            child: const _GameInfoWidget(),
          ),
        ),
        const SliverToBoxAdapter(child: Divider()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          sliver: SliverToBoxAdapter(
            child: ProviderScope(
              overrides: [
                singleDeal.overrideAs((watch) {
                  final index = ref.watch(indexGameLookup);
                  final keys = ref.watch(gameKeysProvider);
                  final game = ref.watch(singleGameLookup);
                  return game.deals.first
                      .copyWith(gameId: keys[index], title: game.info.title);
                }),
              ],
              child: const SavedDealButton(),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          sliver: SliverToBoxAdapter(
            child: CheapestEverWidget(
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const _DealListWidget(),
      ],
    );
  }
}

class _GameInfoWidget extends ConsumerWidget {
  const _GameInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(singleGameLookup).info;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 70, maxWidth: 120),
              child: ProviderScope(
                overrides: [
                  thumbProvider.overrideAs(
                      (watch) => ref.watch(singleGameLookup).info.thumb)
                ],
                child: const ThumbImage(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
            child: Text(info.title),
          ),
        ),
      ],
    );
  }
}

class _DealListWidget extends ConsumerWidget {
  const _DealListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deals = ref.watch(singleGameLookup).deals;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
  }
}

class _EndLinearProgressIndicator extends ConsumerWidget {
  const _EndLinearProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final games = ref.watch(savedGamesPageProvider.state);
    return games.when(
      data: (cb) {
        if (cb.isEmpty && ref.read(savedBoxProvider) is AsyncData)
          return Center(
            child: Text(
              translate.no_game_saved,
              style: Theme.of(context).textTheme.headlineSmall,
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
          child: Text(
            RefreshLocalizations.of(context).currentLocalization.loadFailedText,
          ),
          onPressed: () async =>
              ref.read(savedGamesPageProvider).retrieveNextPage(),
        ),
      ),
    );
  }
}

class PageVisualizer extends StatefulWidget {
  final PageController controller;
  const PageVisualizer({Key? key, this.controller}) : super(key: key);

  @override
  _PageVisualizerState createState() => _PageVisualizerState();
}

class _PageVisualizerState extends State<PageVisualizer> {
  int _currentPage;
  S translate;

  @override
  void initState() {
    super.initState();
    if ((widget.controller.hasClients ?? false) &&
        (widget.controller.page != null ?? false)) {
      _currentPage = widget.controller.page.round();
    } else {
      _currentPage = widget.controller.initialPage;
    }
    widget.controller.addListener(_updatePagination);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
  }

  @override
  void didUpdateWidget(covariant PageVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_updatePagination);
      widget.controller.addListener(_updatePagination);
    }
  }

  void _updatePagination() {
    if ((widget.controller.hasClients ?? false) &&
        widget.controller.page != null) {
      int currentPage = widget.controller.page.round();
      if (currentPage != _currentPage) {
        setState(() => _currentPage = currentPage);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_updatePagination);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer(
          builder: (context, watch, child) {
            final games = ref.watch(savedGamesProvider.state);
            final keys = ref.watch(gameKeysProvider);
            final maxPage = games.length;
            final isEmpty = games.isEmpty;
            String label;
            if (maxPage != 0 && _currentPage < maxPage)
              label =
                  '${_currentPage + 1}: ${games[keys[_currentPage]]?.info?.title ?? ''}';
            _currentPage = _currentPage.clamp(0, isEmpty ? 0 : maxPage - 1);
            String current = '${_currentPage + 1}';
            current = current.padLeft(2, ' ').padLeft(3, ' ');
            return Row(
              children: [
                IconButton(
                  tooltip: translate.first_tooltip,
                  icon: Icon(
                    Icons.skip_previous_outlined,
                    size: DefaultTextStyle.of(context).style.fontSize,
                  ),
                  onPressed: () => widget.controller.hasClients
                      ? widget.controller.jumpToPage(0)
                      : null,
                ),
                Text(current),
                Expanded(
                  child: SizedBox(
                    height: DefaultTextStyle.of(context).style.fontSize,
                    child: Slider.adaptive(
                      max: isEmpty ? 0.0 : (maxPage - 1).toDouble(),
                      divisions: isEmpty ? null : maxPage,
                      value: _currentPage.toDouble(),
                      label: label,
                      onChanged: (newValue) {
                        setState(() => _currentPage = newValue.round());
                      },
                      onChangeEnd: (newValue) {
                        if (newValue != widget.controller.page &&
                            newValue < maxPage)
                          widget.controller.jumpToPage(newValue.round());
                      },
                    ),
                  ),
                ),
                Text('${isEmpty ? 1 : maxPage}'),
                IconButton(
                  tooltip: translate.last_tooltip,
                  iconSize: DefaultTextStyle.of(context).style.fontSize,
                  icon: const Icon(Icons.skip_next_outlined),
                  onPressed: () => widget.controller.hasClients
                      ? widget.controller
                          .jumpToPage(isEmpty ? 0 : (maxPage - 1))
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
