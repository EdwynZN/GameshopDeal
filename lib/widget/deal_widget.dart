import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/widget/display_deal/metacritic.dart';
import 'package:gameshop_deals/widget/display_deal/price_widget.dart';
import 'package:gameshop_deals/widget/display_deal/saved_deal_button.dart';
import 'package:gameshop_deals/widget/display_deal/store_avatar.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:url_launcher/url_launcher.dart';

final indexDeal = ScopedProvider<int>(null);

final _sortByProvider = ScopedProvider<SortBy>((watch) {
  final title = watch(titleProvider);
  return watch(filterProviderCopy(title)).state.sortBy;
}, name: 'Sort By');

class DetailedDeal extends ConsumerWidget {
  const DetailedDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int index = watch(indexDeal);

    final Widget child = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 8.0, bottom: 4, end: 4),
              child: const _TitleDeal(),
            ),
          ),
          Flexible(flex: null, child: Center(child: const PriceWidget())),
        ],
      ),
    );
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: index),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [singleDeal.overrideWithValue(deal)],
            child: const _BottomSheetButtonsDeal(),
          ),
        );
      },
      child: child,
    );
  }
}

class CompactDeal extends ConsumerWidget {
  const CompactDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final String title = deal.title;
    final int index = watch(indexDeal);
    final view = watch(_sortByProvider);
    final bool showMetacritic = view == SortBy.Metacritic;
    final bool showRating = view == SortBy.Reviews;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: Divider.createBorderSide(context)),
      ),
      child: ListTile(
        leading: ProviderScope(
          overrides: [
            indexStore.overrideWithValue(deal.storeId)
          ],
          child: const StoreAvatarIcon(),
        ),
        dense: true,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: _Subtitle(
          showRating: showRating,
          showMetacritic: showMetacritic,
          showStore: false,
        ),
        trailing: const PriceWidget(),
        onTap: () =>
            Navigator.of(context).pushNamed(detailRoute, arguments: index),
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (context) => ProviderScope(
              overrides: [singleDeal.overrideWithValue(deal)],
              child: const _BottomSheetButtonsDeal(),
            ),
          );
        },
      ),
    );
  }
}

class GridDeal extends ConsumerWidget {
  const GridDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int index = watch(indexDeal);
    final color = Colors.grey[850];
    final theme = Theme.of(context);
    final Color borderColor = theme.brightness == Brightness.light
        ? Colors.black38
        : theme.dividerColor;
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: index),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [singleDeal.overrideWithValue(deal)],
            child: const _BottomSheetButtonsDeal(),
          ),
        );
      },
      child: GridTile(
        header: GridTileBar(
          title: Text(
            deal.title,
            maxLines: 2,
          ),
          leading: ProviderScope(
            overrides: [
              indexStore.overrideWithValue(deal.storeId)
            ],
            child: StoreAvatarIcon(size: Theme.of(context).textTheme.bodyText2.fontSize),
          ),
        ),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              tileMode: TileMode.mirror,
              colors: <Color>[
                color,
                color.withOpacity(0.75),
                color.withOpacity(0.0),
              ],
              stops: [0.0, 0.3, 0.5],
            ),
          ),
          child: ProviderScope(
            overrides: [thumbProvider.overrideAs((watch) => watch(singleDeal).thumb)],
            child: const ThumbImage(
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              addInk: true,
            ),
          ),
        ),
        footer: GridTileBar(
          title: const FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            child: const PriceWidget(),
          ),
        ),
      ),
    );
  }
}

class ListDeal extends StatelessWidget {
  const ListDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget child = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 70, maxWidth: 120),
                child: ProviderScope(
                  overrides: [thumbProvider.overrideAs((watch) => watch(singleDeal).thumb)],
                  child: const ThumbImage(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
              child: _TitleDeal(),
            ),
          ),
          Flexible(flex: null, child: PriceWidget()),
        ],
      ),
    );
    return Consumer(
      child: child,
      builder: (context, watch, child) {
        final deal = watch(singleDeal);
        final int index = watch(indexDeal);
        return InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(detailRoute, arguments: index),
          onLongPress: () async {
            showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              builder: (context) => ProviderScope(
                overrides: [singleDeal.overrideWithValue(deal)],
                child: const _BottomSheetButtonsDeal(),
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}

class _TitleDeal extends ConsumerWidget {
  const _TitleDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (deal.title.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 4, end: 4),
            child: Text(
              deal.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 4),
          child: const _Subtitle(),
        ),
      ],
    );
  }
}

class _Subtitle extends ConsumerWidget {
  final bool showStore;
  final bool showMetacritic;
  final bool showReleaseDate;
  final bool showRating;
  final bool showLastChange;

  const _Subtitle({
    Key key,
    bool showStore,
    bool showMetacritic,
    bool showReleaseDate,
    bool showRating,
    bool showLastChange,
  })  : this.showStore = showStore ?? true,
        this.showMetacritic = showMetacritic ?? true,
        this.showReleaseDate = showReleaseDate ?? true,
        this.showRating = showRating ?? true,
        this.showLastChange = showLastChange ?? true,
        super(key: key);

  String _difference(S translate, int mEpoch) {
    final DateTime change = DateTime.fromMillisecondsSinceEpoch(mEpoch * 1000);
    final difference = DateTime.now().difference(change);
    if (difference.inDays >= 365)
      return translate.change_in_years(difference.inDays ~/ 365);
    else if (difference.inDays >= 30)
      return translate.change_in_months(difference.inDays ~/ 30);
    else if (difference.inHours >= 24)
      return translate.change_in_days(difference.inHours ~/ 24);
    else if (difference.inMinutes >= 60)
      return translate.change_in_hours(difference.inMinutes ~/ 60);
    else if (difference.inMinutes >= 1)
      return translate.change_in_minutes(difference.inMinutes);
    else
      return translate.now;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null);
    List<InlineSpan> span = <InlineSpan>[
      if (showStore)
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: ProviderScope(
            overrides: [
              indexStore.overrideWithValue(deal.storeId)
            ],
            child: StoreAvatarIcon(
              size: Theme.of(context).textTheme.bodyText2.fontSize,
            ),
          ),
        ),
    ];
    final int releaseDate = deal.releaseDate;
    if (showReleaseDate && releaseDate != null && releaseDate != 0) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
      final formatShortDate =
          MaterialLocalizations.of(context).formatShortDate(dateTime);
      final bool alreadyRealeased = DateTime.now().isAfter(dateTime);
      final String time = alreadyRealeased
          ? translate.release(formatShortDate)
          : ' ${translate.future_release(formatShortDate)} ';
      span.add(
        TextSpan(
          text: time,
          style: alreadyRealeased
              ? null
              : Theme.of(context).textTheme.overline.copyWith(
                    color: Colors.black,
                    backgroundColor: Colors.orangeAccent,
                  ),
        ),
      );
    }
    if (showMetacritic && deal.metacriticScore != '0') {
      span.add(const WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: const Metacritic(),
      ));
    }
    if (showRating &&
        deal.steamRatingPercent != null &&
        deal.steamRatingText != null) {
      Color color, textColor = Colors.white;
      final int rating = int.tryParse(deal.steamRatingPercent);
      final String ratingText = deal.steamRatingText.replaceAll(' ', '_');
      if (rating >= 95) {
        color = Colors.green[300];
        textColor = Colors.black;
      } else if (rating >= 65) {
        color = Colors.lightGreen[300];
        textColor = Colors.black;
      } else if (rating >= 40) {
        color = Colors.orange;
        textColor = Colors.black;
      } else {
        color = Colors.red[600];
      }
      span.add(
        TextSpan(
          text: '${translate.review(ratingText)}',
          style: Theme.of(context).textTheme.overline.copyWith(
                backgroundColor: color,
                color: textColor,
              ),
        ),
      );
    }
    if (deal.publisher != null) {
      span.add(TextSpan(
        text: deal.publisher,
        style: Theme.of(context).accentTextTheme.overline.copyWith(
              height: 1.5,
              backgroundColor: Theme.of(context).accentColor,
            ),
      ));
    }
    if (showLastChange && deal.lastChange != null) {
      String time = _difference(translate, deal.lastChange);
      span.add(
        TextSpan(text: time),
      );
    }

    for (int i = 1; i < span.length; i = i + 2) {
      span.insert(i, const TextSpan(text: ' · '));
    }

    return RichText(
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      text: TextSpan(
        style: Theme.of(context).textTheme.overline,
        children: span,
      ),
    );
  }
}

class _BottomSheetButtonsDeal extends ConsumerWidget {
  const _BottomSheetButtonsDeal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null, 'deal cannot be null');
    final title = deal.title;
    final metacriticLink = deal.metacriticLink;
    final steamAppId = deal.steamAppId;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border(bottom: Divider.createBorderSide(context))),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        Wrap(
          spacing: 8.0,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            const SavedTextDealButton(),
            TextButton.icon(
              icon: ProviderScope(
                overrides: [
                  indexStore.overrideWithValue(deal.storeId)
                ],
                child: StoreAvatarIcon(
                  size: IconTheme.of(context).size / 1.2,
                ),
              ),
              label: Text(translate.go_to_deal),
              onPressed: () async {
                String _dealLink =
                    '${cheapsharkUrl}/redirect?dealID=${deal.dealId}';
                if (await canLaunch(_dealLink)) {
                  final bool webView = context.read(preferenceProvider.state).webView;
                  await launch(_dealLink, forceWebView: webView, enableJavaScript: webView);
                }
              },
            ),
            if (steamAppId != null) ...[
              TextButton.icon(
                icon: const Icon(Icons.rate_review),
                label: Text(translate.review_tooltip),
                onPressed: () async {
                  final Uri _steamLink = Uri.https(
                    steamUrl,
                    '/app/${deal.steamAppId}',
                  );
                  if (await canLaunch(_steamLink.toString())) {
                    final bool webView = context.read(preferenceProvider.state).webView;
                    await launch(_steamLink.toString(), forceWebView: webView, enableJavaScript: webView);
                  }
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.computer),
                label: const Text('PC Wiki'),
                onPressed: () async {
                  final Uri _pcGamingWikiUri = Uri.https(
                      pcWikiUrl, '/api/appid.php', {'appid': steamAppId});
                  if (await canLaunch(_pcGamingWikiUri.toString())) {
                    final bool webView = context.read(preferenceProvider.state).webView;
                    await launch(_pcGamingWikiUri.toString(), forceWebView: webView, enableJavaScript: webView);
                  }
                },
              ),
            ],
            if (metacriticLink != null)
              TextButton.icon(
                icon: CircleAvatar(
                  radius: IconTheme.of(context).size / 2.4,
                  backgroundImage:
                      const AssetImage('assets/thumbnails/metacritic.png'),
                ),
                label: const Text('Metacritic'),
                onPressed: () async {
                  final Uri _metacriticLink = Uri.https(
                    metacriticUrl,
                    metacriticLink,
                  );
                  if (await canLaunch(_metacriticLink.toString())) {
                    final bool webView = context.read(preferenceProvider.state).webView;
                    await launch(
                      _metacriticLink.toString(),
                      forceWebView: webView,
                      enableJavaScript: webView,
                    );
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}
