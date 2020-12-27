import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class Released extends ConsumerWidget {
  const Released({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int releaseDate = deal.releaseDate;
    if (releaseDate == 0)
      return Text(
        'To be released',
        style: Theme.of(context).textTheme.overline.copyWith(
          color: Colors.black,
          backgroundColor: Colors.orangeAccent,
        ),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      );
    final DateTime released =
        DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
    return Text(
      'Released on: ${MaterialLocalizations.of(context).formatShortDate(released)}',
      style: Theme.of(context).textTheme.overline,
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}