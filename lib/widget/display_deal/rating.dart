import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class DealRating extends ConsumerWidget {
  const DealRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    Color color, textColor = Colors.white;
    final int rating = int.tryParse(deal.steamRatingPercent) ?? 0;
    final String ratingText = deal.steamRatingText.replaceAll(' ', '_');
    if (rating >= 95) {
      color = Colors.greenAccent;
      textColor = Colors.black;
    } else if (rating >= 65) {
      color = Colors.lightGreen;
      textColor = Colors.black;
    } else if (rating >= 40) {
      color = Colors.orange;
      textColor = Colors.black;
    } else {
      color = Colors.red.shade600;
    }
    return Text(
      ' ${translate.review(ratingText)} ',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            backgroundColor: color,
            color: textColor,
          ),
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}
