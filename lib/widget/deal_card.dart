import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleDeal = ScopedProvider<Deal>(null);

class Tile extends ConsumerWidget{
  const Tile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Theme.of(context).dividerColor
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top:4, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                deal.thumb,
                fit: BoxFit.contain,
                errorBuilder: (context,_, __){
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if(deal.title.isNotEmpty) Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(deal.title, maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _Released(),
                  ),
                  const _DealWidget()
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}

class _DealWidget extends ConsumerWidget{
  const _DealWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    final bool score = deal.metacriticScore != '0';
    final int store = int.tryParse(deal.storeId);
    final bool discount = deal.savings != null && deal.savings != 0;
    final brightness = ThemeData.estimateBrightnessForColor(Theme.of(context).scaffoldBackgroundColor);
    final Color discountColor = brightness == Brightness.light ? Colors.green[300] : Colors.greenAccent;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: Image.network('https://www.cheapshark.com/img/stores/icons/${store-1}.png'),
        ),
        if(score) ...<Widget>[
          Image.asset('assets/thumbnails/metacritic.png',
            cacheHeight: 12, cacheWidth: 12,
            width: 12, height: 12, fit: BoxFit.contain,
          ),
          Text(' ${deal.metacriticScore}%', style: Theme.of(context).textTheme.headline2,
          ),
        ],
        const Spacer(),
        if(discount) ...<Widget>[
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              children: [
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
              ]
            ),
            maxLines: 2, softWrap: false,
            overflow: TextOverflow.fade,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 4),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
            decoration: BoxDecoration(
              color: discountColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: Text('-${deal.savings}%',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.black
                )
              ),
            ),
          ),
        ],
        if(!discount) Text('\$${deal.salePrice}', style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}

class _Released extends ConsumerWidget{
  const _Released({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Deal deal = watch(singleDeal);
    final DateTime released = DateTime.fromMillisecondsSinceEpoch(deal.releaseDate * 1000);
    if(deal.releaseDate != 0) return Text('Released on: ${MaterialLocalizations.of(context).formatShortDate(released)}',
      style: Theme.of(context).textTheme.subtitle2,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      color: Colors.orangeAccent,
      child: Text('To be released',style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.black)),
    );
  }
}