import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ThumbImage extends ConsumerWidget {
  const ThumbImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final String thumb = deal.thumb;
    return CachedNetworkImage(
      imageUrl: thumb,
      fit: BoxFit.fitHeight,
      alignment: Alignment.centerLeft,
      cacheManager: watch(cacheManagerFamilyProvider(cacheKeyDeals)),
      errorWidget: (_, __, ___) =>
          const SizedBox(child: const Icon(Icons.error)),
      placeholder: (_, __) => Container(
        constraints: BoxConstraints.tight(const Size.square(35)),
        padding: const EdgeInsets.all(2),
        alignment: Alignment.centerLeft,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}