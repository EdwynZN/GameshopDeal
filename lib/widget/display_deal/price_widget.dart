import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class PriceWidget extends ConsumerWidget {
  const PriceWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
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