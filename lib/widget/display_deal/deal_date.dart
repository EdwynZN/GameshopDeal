import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class DealDate extends ConsumerWidget {
  const DealDate({Key? key}) : super(key: key);

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
    else return translate.now;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    String time = _difference(translate, deal.lastChange);
    return Text(
      time,
      style: Theme.of(context).textTheme.labelSmall,
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}