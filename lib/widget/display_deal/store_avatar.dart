import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:flutter/material.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class StoreAvatarIcon extends ConsumerWidget {
  const StoreAvatarIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int store = int.tryParse(deal.storeId) - 1;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    BlendMode blend =
        brightness == Brightness.light ? BlendMode.dst : BlendMode.srcATop;
    return CachedNetworkImage(
      color: Colors.black26,
      cacheManager: watch(cacheManagerFamilyProvider(cacheKeyStores)),
      height: 14,
      memCacheHeight: 14,
      width: 14,
      memCacheWidth: 14,
      colorBlendMode: blend,
      imageUrl: 'https://www.cheapshark.com/img/stores/icons/$store.png',
    );
  }
}

class StoreAvatarBanner extends ConsumerWidget {
  final Alignment alignment;
  const StoreAvatarBanner({Key key, this.alignment = Alignment.center}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final int store = int.tryParse(deal.storeId) - 1;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    BlendMode blend =
        brightness == Brightness.light ? BlendMode.dst : BlendMode.srcATop;
    return CachedNetworkImage(
      color: Colors.black26,
      alignment: alignment,
      colorBlendMode: blend,
      cacheManager: watch(cacheManagerFamilyProvider(cacheKeyStores)),
      imageUrl: 'https://www.cheapshark.com/img/stores/banners/$store.png',
      placeholder: (_, __) => Align(
        alignment: alignment,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
