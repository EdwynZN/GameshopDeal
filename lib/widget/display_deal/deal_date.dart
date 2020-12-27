import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class DealDate extends ConsumerWidget {
  const DealDate({Key key}) : super(key: key);

  String _difference(Duration difference){
    if (difference.inDays >= 365)
      return '${difference.inDays ~/ 365}y';
    else if (difference.inDays >= 30)
      return '${difference.inDays ~/ 30}mo';
    else if (difference.inHours >= 24)
      return '${(difference.inHours / 24).ceil()}d';
    else if (difference.inMinutes >= 60)
      return '${(difference.inMinutes / 60).ceil()}h';
    else
      return '${difference.inMinutes}m ago';
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int lastChange = deal.lastChange;
    final DateTime change =
      DateTime.fromMillisecondsSinceEpoch(lastChange * 1000);
    final difference = DateTime.now().difference(change);
    String time = _difference(difference);
    return Text(
      ' · $time',
      style: Theme.of(context).textTheme.overline,
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}