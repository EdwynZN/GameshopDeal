import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:gameshop_deals/widget/radial_progression.dart';
import 'package:gameshop_deals/widget/store_deal_widget.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    hide storesProvider, singleStoreProvider;
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
          dealPage.retrievePage();
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
      primary: true,
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
        const _DealListWidget(),
      ],
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
              child: const ThumbImage(),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
                final Uri _metacriticLink = Uri.https(
                  'store.steampowered.com',
                  '/app/${deal.steamAppId}',
                );
                print(_metacriticLink.toString());
                if (await canLaunch(_metacriticLink.toString())) {
                  await launch(
                    _metacriticLink.toString(),
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
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
                      //translate.sort(SortBy.Reviews),
                      translate.review(deal.steamRatingText.replaceAll(' ', '_')),
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (deal.metacriticLink != null && deal.metacriticScore != null) ...[
          const SizedBox(
            width: 8.0,
          ),
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
                final Uri _metacriticLink = Uri.http(
                  'www.metacritic.com',
                  deal.metacriticLink,
                );
                if (await canLaunch(_metacriticLink.toString())) {
                  await launch(
                    _metacriticLink.toString(),
                    forceWebView: true,
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
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
        ]
      ],
    );
  }
}

class _ButtonsDeal extends ConsumerWidget {
  const _ButtonsDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.remove_red_eye),
            label: Flexible(
              child: Text(
                translate.save_deal,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            onPressed: () {
              print('saved');
            },
          ),
        ),
        if (deal.steamAppId != null)
          ...[
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.dashboard_customize),
              label: const Text('PC Wiki'),
              onPressed: () async {
                final Uri _pcGamingWikiUri = Uri.http('pcgamingwiki.com',
                    '/api/appid.php', {'appid': deal.steamAppId});
                if (await canLaunch(_pcGamingWikiUri.toString())) {
                  await launch(_pcGamingWikiUri.toString());
                } else {
                  Scaffold.of(context).showSnackBar(
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
              childCount: deals.length ?? 0,
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
      data: (_) => const SizedBox(
        height: 4.0,
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
