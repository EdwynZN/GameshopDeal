import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/provider/deal_provider.dart' show singleDeal;
import 'package:gameshop_deals/utils/constraints.dart';

class PriceWidget extends ConsumerWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final bool discount = deal.savings != 0;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    final Color discountColor = brightness == Brightness.light
        ? Colors.green.shade300
        : Colors.greenAccent;
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
          Container(
            margin: const EdgeInsetsDirectional.only(start: 4),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            constraints: BoxConstraints.tightForFinite(
                height: (textTheme?.fontSize ?? 0 * 2) +
                    (textTheme?.height ?? 2.0)),
            decoration: BoxDecoration(
              color: Colors.black,
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
    return Text(
      '\$${deal.salePrice}',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

class FlexPriceWidget extends ConsumerWidget {
  final Axis direction;

  const FlexPriceWidget({Key? key, this.direction = Axis.horizontal}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final bool discount = deal.savings != 0;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final brightness = ThemeData.estimateBrightnessForColor(
      theme.scaffoldBackgroundColor,
    );
    final Color discountColor = brightness == Brightness.light
        ? Colors.green.shade700
        : Colors.greenAccent;
    final Color normalPriceColor =
        brightness == Brightness.light ? Colors.grey : Colors.orange;
    final Widget price;
    if (deal.savings == 100 || double.tryParse(deal.salePrice) == 0) {
      price = Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: ShapeDecoration(
          color: discountColor,
          shape: StadiumBorder(),
        ),
        child: Text(
          S.of(context).free,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            letterSpacing: 0.15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
      );
    } else {
      price = Text(
        '\$${deal.salePrice}',
        style: textTheme.titleLarge?.copyWith(
          color: discount ? discountColor : null,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      );
    }
    return Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: direction == Axis.horizontal
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.end,
      crossAxisAlignment: direction == Axis.horizontal
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
      children: [
        if (discount) ...[
          const Spacer(),
          Text(
            '\$${deal.normalPrice}',
            style: textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: normalPriceColor,
              decorationThickness: 2.0,
              color: normalPriceColor,
              height: 1.25,
            ),
            maxLines: 1,
          ),
          gap4,
          price,
        ] else
          price,
      ],
    );
  }
}
