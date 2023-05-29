import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/provider/cache_manager_provider.dart';
import 'package:gameshop_deals/provider/store_provider.dart'
    show singleStoreProvider;
import 'package:flutter/material.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

final storeIdProvider = Provider<String>((_) => throw UnimplementedError());

class StoreAvatarIcon extends ConsumerWidget {
  final double? size;
  const StoreAvatarIcon({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double? iconSize = size ?? IconTheme.of(context).size;
    final id = ref.watch(storeIdProvider);
    final asyncStore = ref.watch(singleStoreProvider(id: int.parse(id)));
    if (!asyncStore.hasValue)
      return Icon(
        Icons.local_grocery_store_outlined,
        size: iconSize,
      );
    final store = asyncStore.requireValue;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    BlendMode blend =
        brightness == Brightness.light ? BlendMode.dst : BlendMode.srcATop;
    return CachedNetworkImage(
      color: Colors.black26,
      cacheManager: ref.watch(cacheManagerProvider(cacheKey: cacheKeyStores)),
      fit: BoxFit.contain,
      height: iconSize,
      memCacheHeight: iconSize?.ceil(),
      width: iconSize,
      memCacheWidth: iconSize?.ceil(),
      colorBlendMode: blend,
      errorWidget: (_, __, ___) => Icon(
        Icons.error_outline,
        size: iconSize,
      ),
      placeholder: (_, __) => Icon(
        Icons.local_grocery_store_outlined,
        size: iconSize,
      ),
      imageUrl: cheapsharkUrl + store.images.icon,
    );
  }
}

class StoreAvatarBanner extends ConsumerWidget {
  final Alignment alignment;
  const StoreAvatarBanner({Key? key, this.alignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(storeIdProvider);
    final asyncStore = ref.watch(singleStoreProvider(id: int.parse(id)));
    if (!asyncStore.hasValue) return const SizedBox.shrink();
    final store = asyncStore.requireValue;
    final brightness = ThemeData.estimateBrightnessForColor(
        Theme.of(context).scaffoldBackgroundColor);
    BlendMode blend =
        brightness == Brightness.light ? BlendMode.dst : BlendMode.srcATop;
    return CachedNetworkImage(
      color: Colors.black26,
      alignment: alignment,
      colorBlendMode: blend,
      cacheManager: ref.watch(cacheManagerProvider(cacheKey: cacheKeyStores)),
      imageUrl: cheapsharkUrl + store.images.banner,
      placeholder: (_, __) => Align(
        alignment: alignment,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
