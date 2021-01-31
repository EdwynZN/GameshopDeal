import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class Released extends ConsumerWidget {
  const Released({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null);
    final int releaseDate = deal.releaseDate;
    if (releaseDate == null || releaseDate == 0) return const SizedBox();
    /*  return Text(
        ' ${translate.no_date} ',
        style: Theme.of(context).textTheme.overline.copyWith(
          color: Colors.black,
          backgroundColor: Colors.orangeAccent,
        ),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ); */
    final dateTime = DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
    final formatShortDate =
        MaterialLocalizations.of(context).formatShortDate(dateTime);
    final bool alreadyRealeased = DateTime.now().isAfter(dateTime);
    if(!alreadyRealeased)
    return Text(
      ' ${translate.future_release(formatShortDate)} ',
      style: Theme.of(context).textTheme.overline.copyWith(
        color: Colors.black,
        backgroundColor: Colors.orangeAccent,
      ),
      overflow: TextOverflow.fade,
      maxLines: 2,
      softWrap: true,
    );
    return Text(
      '${translate.release(formatShortDate)}',
      style: Theme.of(context).textTheme.overline,
      overflow: TextOverflow.clip,
      softWrap: true,
    );
  }
}