import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart' show singleGameLookup;
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/widget/display_deal/saved_deal_button.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:gameshop_deals/widget/display_gamelookup/cheapest_ever.dart';
import 'package:gameshop_deals/widget/radial_progression.dart';
import 'package:gameshop_deals/widget/store_deal_widget.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    hide storesProvider, singleStoreProvider;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDeal extends ConsumerWidget {
  final PageController controller;
  const PageDeal({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    final int childCount = watch(dealsProvider(title).state).length;
    return PageView.custom(
      controller: controller,
      onPageChanged: (index) {
        final dealPage = context.read(dealPageProvider(title));
        if (!dealPage.isLastPage && index == (childCount - 1)) {
          dealPage.retrieveNextPage();
        }
      },
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          if ((childCount == index) &&
              !context.read(dealPageProvider(title)).isLastPage)
            return const EndLinearProgressIndicator();
          else if (index >= childCount) return null;
          return ProviderScope(
            overrides: [
              singleDeal.overrideAs((watch) {
                final title = watch(titleProvider);
                return watch(dealsProvider(title).state)[index];
              })
            ],
            child: const _SwipePage(),
          );
        },
      ),
    );
  }
}

class _SwipePage extends StatelessWidget {
  const _SwipePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: [
        const SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: const SliverToBoxAdapter(
            child: const _DealWidget(),
          ),
        ),
        const SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          sliver: const SliverToBoxAdapter(
            child: const _Stats(),
          ),
        ),
        const SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          sliver: const SliverToBoxAdapter(
            child: const _ButtonsDeal(),
          ),
        ),
        const SliverToBoxAdapter(child: Divider()),
        const SliverToBoxAdapter(child: const _CheapestEverWidget()),
        const _DealListWidget(),
      ],
    );
  }
}

class _CheapestEverWidget extends ConsumerWidget {
  const _CheapestEverWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String gameId = watch(singleDeal).gameId;
    final game = watch(gameDealLookupProvider(gameId));
    return game.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (value) => ProviderScope(
        overrides: [
          singleGameLookup.overrideWithValue(value)
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CheapestEverWidget(
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}

class _DealWidget extends ConsumerWidget {
  const _DealWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null);
    List<InlineSpan> span = <InlineSpan>[];
    final int releaseDate = deal.releaseDate;
    if (releaseDate != null && releaseDate != 0) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
      final formatShortDate =
          MaterialLocalizations.of(context).formatShortDate(dateTime);
      final bool alreadyRealeased = DateTime.now().isAfter(dateTime);
      final String time = alreadyRealeased
          ? translate.release(formatShortDate)
          : '${translate.future_release(formatShortDate)}';
      span.add(
        TextSpan(
          text: time,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: alreadyRealeased ? null : Colors.black,
                backgroundColor: alreadyRealeased ? null : Colors.orangeAccent,
              ),
        ),
      );
    }
    if (deal.publisher != null) {
      span.add(
        TextSpan(
          text: deal.publisher,
          style: Theme.of(context).accentTextTheme.subtitle2.copyWith(
                height: 1.5,
                backgroundColor: Theme.of(context).accentColor,
              ),
        ),
      );
    }
    if (span.length == 2) span.insert(1, const TextSpan(text: ' · '));
    final Widget data = RichText(
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText1,
        children: [
          if (deal.title != null)
            TextSpan(
              text: '${deal.title}\n',
            ),
          ...span
        ],
      ),
    );
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
                  thumbProvider.overrideAs((watch) => watch(singleDeal).thumb)
                ],
                child: const ThumbImage(),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
            child: data,
          ),
        ),
      ],
    );
  }
}

class _Stats extends ConsumerWidget {
  const _Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null);
    List<Widget> widgets = <Widget>[
      if (deal.steamAppId != null && deal.steamRatingPercent != null)
        Expanded(
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style.copyWith(
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) return null;
                return Theme.of(context).cardColor;
              }),
            ),
            onPressed: () async {
              final Uri _steamLink = Uri.https(
                steamUrl,
                '/app/${deal.steamAppId}',
              );
              print(_steamLink.toString());
              if (await canLaunch(_steamLink.toString())) {
                final bool webView =
                    context.read(preferenceProvider.state).webView;
                await launch(
                  _steamLink.toString(),
                  forceWebView: webView,
                  enableJavaScript: webView,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error Launching url')),
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedRadial(percentage: deal.steamRatingPercent),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    translate
                        .review(deal.steamRatingText?.replaceAll(' ', '_')),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      if (deal.metacriticLink != null && deal.metacriticScore != null)
        Expanded(
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style.copyWith(
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) return null;
                return Theme.of(context).cardColor;
              }),
            ),
            onPressed: () async {
              final Uri _metacriticLink = Uri.https(
                metacriticUrl,
                deal.metacriticLink,
              );
              if (await canLaunch(_metacriticLink.toString())) {
                final bool webView =
                    context.read(preferenceProvider.state).webView;
                await launch(_metacriticLink.toString(),
                    forceWebView: webView, enableJavaScript: webView);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error Launching url')),
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedRadial(percentage: deal.metacriticScore),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: IconTheme.of(context).size / 2.4,
                        backgroundImage: const AssetImage(
                            'assets/thumbnails/metacritic.png'),
                      ),
                      SizedBox(width: 8.0),
                      Flexible(
                        child: const Text(
                          'Metacritic',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ];
    if (widgets.length == 2) widgets.insert(1, const SizedBox(width: 8.0));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}

class _ButtonsDeal extends ConsumerWidget {
  const _ButtonsDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: const SavedDealButton(),
        ),
        if (deal.steamAppId != null) ...[
          const SizedBox(width: 8.0),
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.computer),
              label: const Text('PC Wiki'),
              onPressed: () async {
                final Uri _pcGamingWikiUri = Uri.https(
                    pcWikiUrl, '/api/appid.php', {'appid': deal.steamAppId});
                if (await canLaunch(_pcGamingWikiUri.toString())) {
                  final bool webView =
                      context.read(preferenceProvider.state).webView;
                  await launch(_pcGamingWikiUri.toString(),
                      forceWebView: webView, enableJavaScript: webView);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error Launching url')),
                  );
                }
              },
            ),
          ),
        ]
      ],
    );
  }
}

class _DealListWidget extends ConsumerWidget {
  const _DealListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
              childCount: deals?.length ?? 0,
            ),
          ),
        );
      },
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
      data: (_) => const SizedBox(height: 4.0),
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
              context.read(dealPageProvider(title)).retrieveNextPage(),
        ),
      ),
    );
  }
}

class PageVisualizer extends StatefulWidget {
  final PageController controller;
  const PageVisualizer({Key key, this.controller}) : super(key: key);

  @override
  _PageVisualizerState createState() => _PageVisualizerState();
}

class _PageVisualizerState extends State<PageVisualizer> {
  int _currentPage;
  S translate;

  @override
  void initState() {
    super.initState();
    if ((widget.controller?.hasClients ?? false) &&
        (widget.controller?.page != null ?? false)) {
      _currentPage = widget.controller.page.round();
    } else {
      _currentPage = widget.controller.initialPage;
    }
    widget.controller?.addListener(_updatePagination);
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
      oldWidget.controller?.removeListener(_updatePagination);
      widget.controller?.addListener(_updatePagination);
    }
  }

  void _updatePagination() {
    if ((widget.controller?.hasClients ?? false) &&
        widget.controller?.page != null) {
      int currentPage = widget.controller.page.round();
      if (currentPage != _currentPage) {
        setState(() => _currentPage = currentPage);
      }
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer(
          builder: (_, watch, __) {
            final title = watch(titleProvider);
            final deals = watch(dealsProvider(title).state);
            final maxPage = deals.length;
            final isEmpty = deals.isEmpty;
            String label;
            if (maxPage != 0 && _currentPage < maxPage)
              label =
                  '${_currentPage + 1}: ${deals[_currentPage]?.title ?? ''}';
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
