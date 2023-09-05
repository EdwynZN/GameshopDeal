import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/price_ui.dart';
import 'package:gameshop_deals/presentation/widgets/material_card.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/thumb_image.dart';
import 'package:gameshop_deals/provider/deal_detail_provider.dart';
import 'package:gameshop_deals/utils/cheapshark_url_formater.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailScreen extends HookConsumerWidget {
  final String dealId;

  const GameDetailScreen({super.key, required this.dealId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lookup = ref.watch(dealDetailProvider(dealId: dealId));
    final list = lookup.when(
      loading: () => const [
        SliverToBoxAdapter(child: LinearProgressIndicator()),
      ],
      error: (error, stackTrace) {
        return [
          SliverToBoxAdapter(),
        ];
      },
      data: (data) => [
        SliverToBoxAdapter(
          child: _DetailCard(
            title: data.info.name,
            image: data.info.thumb,
            publisher: data.info.publisher,
            date: data.info.releaseDate,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisExtent: 125,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final deal = data.cheaperStores[index];
              return _DealStore(
                isSelected: index == 0,
                storeId: deal.storeId,
                priceUI: PriceUI.fromPrice(
                  normalPrice: double.tryParse(deal.retailPrice) ?? 0,
                  salePrice: double.tryParse(deal.salePrice) ?? 0,
                ),
                uri: dealUri(deal.dealId),
              );
            },
            itemCount: data.cheaperStores.length,
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(elevation: 4.0),
      body: CustomScrollView(slivers: list),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final String? publisher;
  final DateTime? date;
  final String image;

  const _DetailCard({
    // ignore: unused_element
    super.key,
    required this.title,
    required this.image,
    // ignore: unused_element
    this.publisher,
    // ignore: unused_element
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final asset = ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        width: 140.0,
        height: 82.0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ColoredBox(
          color: ElevationOverlay.applySurfaceTint(
            theme.colorScheme.background,
            theme.colorScheme.secondary,
            2.0,
          ),
          child: ProviderScope(
            overrides: [thumbProvider.overrideWithValue(image)],
            child: const ThumbImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    final Widget info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            height: 0.0,
          ),
          maxLines: 2,
        ),
        if (publisher != null) ...[
          gap4,
          Text(
            publisher!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
          ),
        ] else
          gap8,
        if (date != null) ...[
          gap4,
          Text(
            MaterialLocalizations.of(context).formatShortDate(date!),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.25,
            ),
            maxLines: 2,
          ),
        ],
      ],
    );

    final Widget child = DefaultTextStyle.merge(
      style: TextStyle(color: theme.appBarTheme.foregroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: info),
            gap12,
            asset,
          ],
        ),
      ),
    );

    return TonalCard(
      margin: emptyPadding,
      elevation: 4.0,
      color: theme.appBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
      ),
      child: child,
    );
  }
}

class _DealStore extends StatelessWidget {
  final PriceUI priceUI;
  final bool isSelected;
  final String storeId;
  final Uri uri;

  const _DealStore({
    // ignore: unused_element
    super.key,
    required this.priceUI,
    required this.isSelected,
    required this.storeId,
    required this.uri,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PriceTheme priceTheme = theme.extension<PriceTheme>()!;
    final textTheme = theme.textTheme;
    final Color discountColor = priceTheme.discountColor;
    final Color normalPriceColor = priceTheme.regularColor;
    final Widget price;
    if (priceUI.isFree) {
      price = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: ShapeDecoration(
          color: discountColor,
          shape: const StadiumBorder(),
        ),
        child: Text(
          S.of(context).free,
          style: TextStyle(
            color: priceTheme.onDiscountColor,
            fontSize: 14.0,
            letterSpacing: 0.15,
            fontWeight: FontWeight.normal,
          ),
          maxLines: 1,
        ),
      );
    } else {
      price = Text(
        '\$${priceUI.salePrice}',
        style: textTheme.titleLarge?.copyWith(
          color: priceUI.hasDiscount ? discountColor : null,
          fontSize: 14.0,
          letterSpacing: -0.15,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
      );
    }

    final asset = ConstrainedBox(
      constraints: const BoxConstraints.tightForFinite(height: 36.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ProviderScope(
          overrides: [storeIdProvider.overrideWithValue(storeId)],
          child: const StoreAvatarBanner(alignment: Alignment.center),
        ),
      ),
    );
/* 
    final timer = Chip(
      avatar: Icon(
        Icons.timelapse_outlined,
        size: 14.0,
        color: theme.colorScheme.tertiary,
      ),
      label: Text(
        S.of(context).change_in_hours(lastChange),
      ),
      labelStyle: TextStyle(
        fontSize: 10.0,
        height: 0.0,
        color: theme.colorScheme.onTertiaryContainer,
      ),
      labelPadding: horizontalPadding4,
      visualDensity: const VisualDensity(
        horizontal: -2.0,
        vertical: -2.0,
      ),
      shape: const StadiumBorder(),
      elevation: 0.0,
      backgroundColor: ElevationOverlay.applySurfaceTint(
        theme.colorScheme.background,
        theme.colorScheme.tertiary,
        isSelected ? 12.0 : 6.0,
      ),
      side: BorderSide.none,
    );
 */
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          asset,
          //gap4,
          //timer,
          gap16,
          if (priceUI.hasDiscount) ...[
            Center(
              child: Text(
                '\$${priceUI.normalPrice}',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 11.0,
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: normalPriceColor,
                  decorationThickness: 1.0,
                  color: normalPriceColor,
                  height: 0.5,
                ),
                maxLines: 1,
              ),
            ),
            gap8,
          ],
          price,
        ],
      ),
    );

    if (isSelected) {
      final best = Align(
        alignment: Alignment.topLeft,
        child: Material(
          type: MaterialType.canvas,
          color: theme.colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 12.0,
            ),
            child: Text(
              'best',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.15,
              ),
            ),
          ),
        ),
      );
      child = Stack(
        fit: StackFit.passthrough,
        children: [child, best],
      );
    }

    return TonalCard(
      elevation: isSelected ? 4.0 : 1.0,
      margin: emptyPadding,
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(
          theme.colorScheme.primary.withOpacity(0.08),
        ),
        onTap: () async {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error Launching url')),
            );
          }
        },
        child: child,
      ),
    );
  }
}
