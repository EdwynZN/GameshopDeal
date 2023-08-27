import 'package:flutter_hooks/flutter_hooks.dart';
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
      cacheManager: ref.watch(cacheManagerProvider(cacheKey: cacheKeyDeals)),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
      placeholder: (_, __) => const _LoadingAsset(),
    );
  }
}

class _LoadingAsset extends HookWidget {
  // ignore: unused_element
  const _LoadingAsset({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerColor = theme.colorScheme.tertiary;
    final initialColor = ElevationOverlay.applySurfaceTint(
      theme.colorScheme.surface,
      containerColor,
      3.0,
    );
    final endColor = ElevationOverlay.applySurfaceTint(
      theme.colorScheme.surface,
      containerColor,
      12.0,
    );
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
      animationBehavior: AnimationBehavior.preserve,
      reverseDuration: const Duration(seconds: 1, milliseconds: 500),
      keys: const [],
    );
    final animColor = useMemoized(
      () => ColorTween(begin: initialColor, end: endColor).animate(controller),
      [controller, initialColor, endColor],
    );
    useEffect(() {
      controller.repeat(reverse: true);
      return;
    }, const []);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) =>
          ColoredBox(color: animColor.value ?? Colors.transparent),
    );
  }
}
