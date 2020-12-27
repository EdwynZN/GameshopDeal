import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;

final indexDeal = ScopedProvider<int>(null);

class TileDeal extends StatelessWidget {
  final bool showDeal;
  const TileDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 70, maxWidth: 120),
                child: const _ThumbImage(),
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
                        Flexible(flex: null, child: const _DealWidget())
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
    return Container(
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
                child: const _ThumbImage(),
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
                        Flexible(flex: null, child: const _DealWidget())
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

class _DealWidget extends ConsumerWidget {
  const _DealWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    //final Deal deal = watch(singleDealProvider(watch(indexDeal)));
    final bool discount = deal.savings != null && deal.savings != 0;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    final Color discountColor =
        brightness == Brightness.light ? Colors.green[300] : Colors.greenAccent;
    if (discount)
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(children: [
              TextSpan(
                text: '\$${deal.normalPrice}\n',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                    ),
              ),
              TextSpan(
                text: '\$${deal.salePrice}',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: discountColor,
                    ),
              ),
            ]),
            maxLines: 2,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 4),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
            decoration: BoxDecoration(
              color: discountColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: Text(
                '-${deal.savings}%',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      );
    return Text('\$${deal.salePrice}',
        style: Theme.of(context).textTheme.subtitle1);
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
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    //final Deal deal = watch(singleDealProvider(watch(indexDeal)));
    final bool score = deal.metacriticScore != '0';
    final bool changed = deal.lastChange != 0;
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
        DefaultTextStyle(
          style: Theme.of(context).textTheme.overline,
          child: Wrap(
            runSpacing: 2.0,
            children: [
              const _Released(),
              if (score) ...[const Text(' · '), const _Metacritic()],
              if (changed != 0 && showStore) const _DealDate(),
              if (showStore) ...[
                const Text(' · '),
                const _StoreAvatar(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ThumbImage extends ConsumerWidget {
  const _ThumbImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    //final Deal deal = watch(singleDealProvider(watch(indexDeal)));
    final String thumb = deal.thumb;
    return CachedNetworkImage(
      imageUrl: thumb,
      fit: BoxFit.fitHeight,
      alignment: Alignment.centerLeft,
      cacheManager: watch(cacheManagerFamilyProvider(cacheKeyDeals)),
      errorWidget: (_, __, ___) =>
          const SizedBox(child: const Icon(Icons.error)),
      placeholder: (_, __) => Container(
        constraints: BoxConstraints.tight(const Size.square(35)),
        padding: const EdgeInsets.all(2),
        alignment: Alignment.centerLeft,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _StoreAvatar extends ConsumerWidget {
  const _StoreAvatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    //final Deal deal = watch(singleDealProvider(watch(indexDeal)));
    final bool score = deal.metacriticScore != '0';
    final int store = int.tryParse(deal.storeId);
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    BlendMode blend =
        brightness == Brightness.light ? BlendMode.dstIn : BlendMode.exclusion;
    return CachedNetworkImage(
      cacheManager: watch(cacheManagerFamilyProvider(cacheKeyStores)),
      height: 14,
      memCacheHeight: 14,
      width: 14,
      memCacheWidth: 14,
      color: Theme.of(context).scaffoldBackgroundColor,
      colorBlendMode: blend,
      imageUrl: 'https://www.cheapshark.com/img/stores/icons/${store - 1}.png',
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (store != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: CachedNetworkImage(
              cacheManager: watch(cacheManagerFamilyProvider(cacheKeyStores)),
              height: 16,
              color: Theme.of(context).scaffoldBackgroundColor,
              colorBlendMode: blend,
              imageUrl:
                  'https://www.cheapshark.com/img/stores/banners/${store - 1}.png',
            ),
          ),
        if (score) ...<Widget>[
          const CircleAvatar(
            radius: 8,
            backgroundImage:
                const AssetImage('assets/thumbnails/metacritic.png'),
          ),
          Text('· ${deal.metacriticScore}%'),
        ],
      ],
    );
  }
}

class _Metacritic extends ConsumerWidget {
  const _Metacritic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    //final Deal deal = watch(singleDealProvider(watch(indexDeal)));
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        const CircleAvatar(
          radius: 6,
          backgroundImage: const AssetImage('assets/thumbnails/metacritic.png'),
        ),
        Text(' ${deal.metacriticScore}%'),
      ],
    );
  }
}

class _Released extends ConsumerWidget {
  const _Released({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    final int releaseDate = deal.releaseDate;
    //final int releaseDate = watch(singleDealProvider(watch(indexDeal))).releaseDate;
    if (releaseDate == 0)
      return Text(
        'To be released',
        style: Theme.of(context).textTheme.overline.copyWith(
              color: Colors.black,
              backgroundColor: Colors.orangeAccent,
            ),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      );
    final DateTime released =
        DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
    return Text(
      'Released on: ${MaterialLocalizations.of(context).formatShortDate(released)}',
      style: Theme.of(context).textTheme.overline,
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}

class _DealDate extends ConsumerWidget {
  const _DealDate({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    assert(deal != null);
    final int lastChange = deal.lastChange;
    //final int lastChange = watch(singleDealProvider(watch(indexDeal))).lastChange;
    final DateTime change =
        DateTime.fromMillisecondsSinceEpoch(lastChange * 1000);
    final difference = DateTime.now().difference(change);
    String time;
    if (difference.inDays >= 365)
      time = '${difference.inDays ~/ 365}y';
    else if (difference.inDays >= 30)
      time = '${difference.inDays ~/ 30}mo';
    else if (difference.inHours >= 24)
      time = '${(difference.inHours / 24).ceil()}d';
    else if (difference.inMinutes >= 60)
      time = '${(difference.inMinutes / 60).ceil()}h';
    else
      time = '${difference.inMinutes}m ago';
    return Text(
      ' · $time',
      style: Theme.of(context).textTheme.overline,
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}