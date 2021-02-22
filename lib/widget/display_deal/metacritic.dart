import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class Metacritic extends ConsumerWidget {
  const Metacritic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int metaScore = int.tryParse(deal.metacriticScore);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CircleAvatar(
          radius: 6,
          backgroundImage: const AssetImage('assets/thumbnails/metacritic.png'),
        ),
        Text(
          ' ${metaScore}%',
          style: Theme.of(context).textTheme.overline.copyWith(
            //color: textColor,
          ),        
        ),
      ],
    );
  }
}