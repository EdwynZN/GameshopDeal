import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/deal_provider.dart' show singleDeal;

class Metacritic extends ConsumerWidget {
  const Metacritic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final int? metaScore = int.tryParse(deal.metacriticScore);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const CircleAvatar(
          radius: 6,
          backgroundImage: const AssetImage('assets/thumbnails/metacritic.png'),
        ),
        Text(
          ' ${metaScore}%',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
