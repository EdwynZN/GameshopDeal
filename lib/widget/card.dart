import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:intl/intl.dart';

const double _radius = 30.0;
const String lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit';

class StylishCard extends StatelessWidget{
  static const double _radius = 30.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(8),
              topLeft: Radius.circular(0)
            )
          ),
          margin: const EdgeInsets.only(left: 8, right: 8, top: _radius, bottom: 4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: _radius * 2, bottom: 5),
                  child: Text(
                    lorem,
                    style: Theme.of(context).textTheme.title,
                    maxLines: 1, softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Text(
                  'You have pushed the button this many times: 1.0',
                ),
                Text(
                  'Text',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 8,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).cardTheme.color,
            radius: _radius,
            child: const Icon(Icons.check_circle, color: Colors.black, size: _radius * 2),
          ),
        ),
      ],
    );
  }
}

class DealCard extends StatelessWidget{
  final Deal deal;
  final bool score;

  DealCard({
    Key key,
    this.deal}) :
        score = deal.metacriticScore != '0',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(0)
              )
          ),
          margin: const EdgeInsets.only(left: 8, right: 8, top: _radius, bottom: 4),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: _radius * 2, bottom: 5),
                    child: Text(
                      deal.title,
                      style: Theme.of(context).textTheme.title,
                      maxLines: 1, softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      _Released(deal.releaseDate),
                      const SizedBox(width: 10,),
                      if(score)
                        _Metacritic(deal.metacriticScore),
                      Text(deal.storeId)
                    ],
                  ),
                  _Discount(deal.normalPrice, deal.salePrice, deal.savings),
                ],
              )
          ),
        ),
        Positioned(
            left: 8,
            child: Image.network(
              deal.thumb,
              cacheWidth: 60, cacheHeight: 60,
              fit: BoxFit.fitWidth,
              height: _radius * 2,
              width: _radius * 2,
            )
        ),
        /*
        Positioned(
            left: 8,
            child: CircleAvatar(
              radius: _radius,
              //backgroundColor: Colors.yellowAccent,
              backgroundColor: Theme.of(context).cardTheme.color,
              child: CachedNetworkImage(
                imageUrl: deal.thumb,
                fit: BoxFit.contain,
                height: _radius, width: _radius * 2,
              ),
            )
        ),
        */
      ],
    );
  }
}

class DealCard2 extends StatelessWidget{
  final Deal deal;
  final bool score;

  DealCard2({
    Key key,
    this.deal}) :
      score = deal.metacriticScore != '0',
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topRight: Radius.circular(0),
              topLeft: Radius.circular(0)
          )
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 10, 10),
        child: Row(
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: SizedBox(
                width: _radius * 2.5, height: _radius * 2.5,
                child: Image.network(
                  deal.thumb,
                  //cacheWidth: 60, cacheHeight: 60,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if(deal.title.isNotEmpty) Text(
                    deal.title,
                    //style: Theme.of(context).textTheme.body1,
                    //maxLines: 1, softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 4,),
                  _Released(deal.releaseDate),
                  const SizedBox(height: 4,),
                  Row(
                    children: <Widget>[
                      if(score) Flexible(child: _Metacritic(deal.metacriticScore)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.network('https://www.cheapshark.com/img/stores/icons/12.png',
                          height: 24,
                        ),
                      ),
                      _Discount(deal.normalPrice, deal.salePrice, deal.savings),
                    ],
                  )
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}

class _Released extends StatelessWidget{
  static final DateFormat _format = DateFormat.yMMMMd('en_US');
  final int releaseDate;
  final String released;

  _Released(this.releaseDate) :
    released = releaseDate == 0 ? null : _format.format(DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000));

  @override
  Widget build(BuildContext context) {
    if(released != null)
      return Text('Released on: $released',
        style: Theme.of(context).textTheme.subtitle,
      );
    else
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        color: Colors.orangeAccent,
        child: Text('To be released',
          style: Theme.of(context).textTheme.subtitle.copyWith(
          color: Colors.black
          )
        ),
      );
  }
}

class _Metacritic extends StatelessWidget{
  final String metacritic;

  const _Metacritic(this.metacritic);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('assets/thumbnails/metacritic.png',
            width: 14, height: 14, fit: BoxFit.contain,
          ),
          Text(' $metacritic%',
            style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _Discount extends StatelessWidget{
  final String normalPrice;
  final String salePrice;
  final int savings;
  final bool discount;

  _Discount(this.normalPrice, this.salePrice, this.savings) :
    discount = savings != 0 && savings != null;

  @override
  Widget build(BuildContext context) {
    if(discount)
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$$normalPrice',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                    text: '\n',
                    style: Theme.of(context).textTheme.subtitle
                ),
                TextSpan(
                  text: '\$$salePrice',
                  style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.green,
                  ),
                ),
              ]
            ),
            maxLines: 2, softWrap: false,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(width: 4),
          Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: Text('-$savings%',
                style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.black
                )
              ),
            ),
          ),
        ],
      );
    else
      return Align(
        alignment: Alignment.centerRight,
        child: Text('\$$salePrice', style: Theme.of(context).textTheme.subhead,),
      );
  }
}