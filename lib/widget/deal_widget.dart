import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/widget/display_deal/metacritic.dart';
import 'package:gameshop_deals/widget/display_deal/price_widget.dart';
import 'package:gameshop_deals/widget/display_deal/store_avatar.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:url_launcher/url_launcher.dart';

final indexDeal = ScopedProvider<int>(null);

final _sortByProvider = ScopedProvider<SortBy>((watch) {
  final title = watch(titleProvider);
  return watch(filterProviderCopy(title)).state.sortBy;
}, name: 'Sort By');

class DetailedDeal extends ConsumerWidget {
  final bool showDeal;
  const DetailedDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

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
              child: _TitleDeal(showStore: showDeal),
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
        leading: const StoreAvatarIcon(),
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
          leading: const StoreAvatarIcon(size: 14),
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
          child: const ThumbImage(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            addInk: true,
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

class TileDeal extends StatelessWidget {
  final bool showDeal;
  const TileDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
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
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0),
              child: showDeal
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: const _TitleDeal()),
                        Flexible(flex: null, child: const PriceWidget())
                      ],
                    )
                  : const _TitleDeal(showStore: false),
            ),
          ),
        ],
      ),
    );
  }
}

class ListDeal extends StatelessWidget {
  final bool showDeal;
  const ListDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

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
                child: const ThumbImage(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 8.0, end: 4),
              child: _TitleDeal(showStore: showDeal),
            ),
          ),
          if (showDeal) Flexible(flex: null, child: PriceWidget()),
        ],
      ),
    );
    if (!showDeal) return child;
    return Consumer(
      child: child,
      builder: (context, watch, child) {
        final deal = watch(singleDeal);
        final int index = watch(indexDeal);
        return InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(detailRoute, arguments: index),
          onLongPress: !showDeal
              ? null
              : () async {
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
  final bool showStore;
  const _TitleDeal({
    this.showStore = true,
    Key key,
  })  : assert(showStore != null, 'showDeal cannot be \'null\''),
        super(key: key);

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
          child: showStore ? const _Subtitle() : const _Subtitle.gameOnly(),
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

  const _Subtitle.gameOnly({
    Key key,
    bool showMetacritic,
    bool showReleaseDate,
    bool showRating,
  })  : this.showStore = false,
        this.showMetacritic = showMetacritic ?? true,
        this.showReleaseDate = showReleaseDate ?? true,
        this.showRating = showRating ?? true,
        this.showLastChange = false,
        super(key: key);

  String _difference(S translate, int mEpoch) {
    final DateTime change = DateTime.fromMillisecondsSinceEpoch(mEpoch * 1000);
    final difference = DateTime.now().difference(change);
    if (difference.inDays >= 365)
      return translate.change_in_years(difference.inDays ~/ 365);
    else if (difference.inDays >= 30)
      return translate.change_in_months(difference.inDays ~/ 30);
    else if (difference.inHours >= 24)
      return translate.change_in_days((difference.inHours / 24).ceil());
    else if (difference.inMinutes >= 60)
      return translate.change_in_hours((difference.inMinutes / 60).ceil());
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
          child: StoreAvatarIcon(
            size: Theme.of(context).textTheme.bodyText2.fontSize,
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
            TextButton.icon(
              icon: const Icon(Icons.remove_red_eye),
              label: Text(translate.save_deal),
              onPressed: () {
                print('saved');
                Navigator.maybePop(context);
              },
            ),
            TextButton.icon(
              icon: StoreAvatarIcon(
                size: IconTheme.of(context).size / 1.2,
              ),
              label: Text(translate.go_to_deal),
              onPressed: () async {
                String _dealLink =
                    'https://www.cheapshark.com/redirect?dealID=${deal.dealId}';
                if (await canLaunch(_dealLink)) await launch(_dealLink);
              },
            ),
            if (steamAppId != null)
              ...[
                TextButton.icon(
                  icon: const Icon(Icons.rate_review),
                  label: Text(translate.review_tooltip),
                  onPressed: () async {
                    final Uri _steamLink = Uri.https(
                      'store.steampowered.com',
                      '/app/${deal.steamAppId}',
                    );
                    if (await canLaunch(_steamLink.toString())) {
                      await launch(_steamLink.toString());
                    } 
                  },
                ),
                TextButton.icon(
                  icon: const Icon(Icons.computer),
                  label: const Text('PC Wiki'),
                  onPressed: () async {
                    final Uri _pcGamingWikiUri = Uri.http('pcgamingwiki.com',
                        '/api/appid.php', {'appid': steamAppId});
                    if (await canLaunch(_pcGamingWikiUri.toString())) {
                      await launch(_pcGamingWikiUri.toString());
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
                  final Uri _metacriticLink = Uri.http(
                    'www.metacritic.com',
                    metacriticLink,
                  );
                  if (await canLaunch(_metacriticLink.toString())) {
                    await launch(
                      _metacriticLink.toString(),
                      forceWebView: true,
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