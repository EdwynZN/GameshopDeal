import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/cache_manager_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

final thumbProvider = Provider<String>((_) => throw UnimplementedError());

class ThumbImage extends ConsumerWidget {
  final Alignment alignment;
  final BoxFit fit;
  final bool addInk;

  const ThumbImage({
    Key? key,
    this.alignment = Alignment.centerLeft,
    this.fit = BoxFit.fitHeight,
    this.addInk = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumb = ref.watch(thumbProvider);
    return CachedNetworkImage(
      imageUrl: thumb,
      fit: fit,
      alignment: alignment,
      imageBuilder: !addInk
          ? null
          : (context, imageProvider) => Ink.image(
                image: imageProvider,
                alignment: alignment,
                fit: fit,
              ),
      cacheManager: ref.watch(cacheManagerFamilyProvider(cacheKeyDeals)),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
      placeholder: (_, __) => Container(
        constraints: BoxConstraints.tight(const Size.square(35)),
        padding: const EdgeInsets.all(2),
        alignment: alignment,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
