import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/deal_provider.dart' show singleDeal;

class PriceWidget extends ConsumerWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final bool discount = deal.savings != 0;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    final Color discountColor =
        brightness == Brightness.light ? Colors.green.shade300 : Colors.greenAccent;
    final Color normalPriceColor =
        brightness == Brightness.light ? Colors.red : Colors.orange;
    final textTheme = Theme.of(context).textTheme.titleSmall;
    if (discount)
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(children: [
              TextSpan(
                text: '\$${deal.normalPrice}\n',
                style: textTheme?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 2.0,
                  color: normalPriceColor,
                ),
              ),
              TextSpan(
                text: '\$${deal.salePrice}',
                style: textTheme?.copyWith(color: discountColor),
              ),
            ]),
            maxLines: 2,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          /* IntrinsicHeight(
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 4),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              decoration: BoxDecoration(
                color: discountColor,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              alignment: Alignment.center,
              child: Text(
                '-${deal.savings}%',
                style: textTheme.copyWith(color: Colors.black),
              ),
            ),
          ), */
          Container(
            margin: const EdgeInsetsDirectional.only(start: 4),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            constraints: BoxConstraints.tightForFinite(
                height: (textTheme?.fontSize ?? 0 * 2) + (textTheme?.height ?? 2.0)),
            decoration: BoxDecoration(
              color: discountColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            alignment: Alignment.center,
            child: Text(
              '-${deal.savings}%',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ],
      );
    return Text('\$${deal.salePrice}',
        style: Theme.of(context).textTheme.titleMedium);
  }
}