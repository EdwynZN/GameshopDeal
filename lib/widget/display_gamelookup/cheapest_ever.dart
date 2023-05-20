import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart'
    show singleGameLookup;

class CheapestEverWidget extends ConsumerWidget {
  final TextStyle? style;
  const CheapestEverWidget({Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final cheap = ref.watch(singleGameLookup).cheapestPrice;
    if (cheap.price.isEmpty)
      return const SizedBox.shrink();
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(cheap.date * 1000);
    final localizedDate =
        MaterialLocalizations.of(context).formatShortDate(date);
    final textStyle = style ?? Theme.of(context).textTheme.titleSmall;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle?.copyWith(fontWeight: FontWeight.normal),
        children: [
          TextSpan(
            text: translate.cheapest_ever,
            style: textStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: translate.cheapest_price_and_date(cheap.price, localizedDate),
          ),
        ],
      ),
    );
  }
}
