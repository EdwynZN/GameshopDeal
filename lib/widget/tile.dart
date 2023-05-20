import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/deal.dart';

class Tile extends StatelessWidget{
  final Deal deal;
  final bool score;
  final int store;

  Tile({super.key, required this.deal}) :
    score = deal.metacriticScore != '0',
    store = int.parse(deal.storeId);

  @override
  Widget build(BuildContext context) {
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
                //width: _radius * 2.5,
                //height: 110,//_radius * 2.5,
                //cacheWidth: 60, cacheHeight: 60,
                //cacheHeight: 60,
                fit: BoxFit.contain,
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _Released(deal.releaseDate),
                  ),
                  _DealWidget(
                    score,
                    deal.metacriticScore,
                    store,
                    deal.normalPrice,
                    deal.salePrice,
                    deal.savings
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}

class _DealWidget extends StatelessWidget {
  final bool score;
  final String metacritic;
  final int store;
  final String normalPrice;
  final String salePrice;
  final int savings;
  final bool discount;

  const _DealWidget(
    this.score,
    this.metacritic,
    this.store,
    this.normalPrice,
    this.salePrice,
    this.savings,
  ) : discount = savings != 0;

  @override
  Widget build(BuildContext context) {
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
          Text(' $metacritic%', style: Theme.of(context).textTheme.displayMedium,
        ),
        ],
        const Spacer(),
        if(discount) ...<Widget>[
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$$normalPrice\n',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                    ),
                  ),
                  TextSpan(
                    text: '\$$salePrice',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.greenAccent,
                    ),
                  ),
                ]
            ),
            maxLines: 2, softWrap: false,
            overflow: TextOverflow.fade,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 4),
            //height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: Text('-$savings%',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black
                )
              ),
            ),
          ),
        ],
        if(!discount) Text('\$$salePrice', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _Released extends StatelessWidget{
  final DateTime? released;

  _Released(int releaseDate) :
    released = releaseDate == 0 ? null : DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);

  @override
  Widget build(BuildContext context) {
    if(released != null)
      return Text('Released on: ${MaterialLocalizations.of(context).formatShortDate(released!)}',
        style: Theme.of(context).textTheme.titleSmall,
      );
    else
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        color: Colors.orangeAccent,
        child: Text('To be released',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.black
          )
        ),
      );
  }
}