import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';

class Metacritic extends ConsumerWidget {
  const Metacritic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        const CircleAvatar(
          radius: 6,
          backgroundImage: const AssetImage('assets/thumbnails/metacritic.png'),
        ),
        Text(' ${deal.metacriticScore}%'),
      ],
    );
  }
}