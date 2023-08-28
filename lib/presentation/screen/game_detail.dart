import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/presentation/widgets/material_card.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameDetailScreen extends HookConsumerWidget {
  final String id;

  const GameDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _DetailCard()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisExtent: 150,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return _DealStore(
                  isSelected: index == 0,
                );
              },
              itemCount: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Widget info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Super smash bros ultimate',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            height: 0.0,
          ),
          maxLines: 2,
        ),
        gap4,
        Text(
          'Nintendo',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
          maxLines: 1,
        ),
        gap4,
        Text(
          MaterialLocalizations.of(context).formatShortDate(DateTime.now()),
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.25,
          ),
          maxLines: 2,
        ),
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
            Container(
              width: 140.0,
              height: 82.0,
              decoration: ShapeDecoration(
                color: theme.colorScheme.secondaryContainer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Card(
      margin: emptyPadding,
      elevation: 0.0,
      color: theme.appBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
      ),
      child: child,
    );
  }
}

class _DealStore extends StatelessWidget {
  final bool isSelected;

  const _DealStore({
    // ignore: unused_element
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savings = 100;
    final salePrice = '12';
    final normalPrice = '99';
    final PriceTheme priceTheme = theme.extension<PriceTheme>()!;
    final bool discount = savings != 0;
    final textTheme = theme.textTheme;
    final Color discountColor = priceTheme.discountColor;
    final Color normalPriceColor = priceTheme.regularColor;
    final Widget price;
    if (savings == 100 || double.tryParse(salePrice) == 0) {
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
        '\$$salePrice',
        style: textTheme.titleLarge?.copyWith(
          color: discount ? discountColor : null,
          fontSize: 14.0,
          letterSpacing: -0.15,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
      );
    }

    final timer = Chip(
      avatar: Icon(
        Icons.timelapse_outlined,
        size: 14.0,
        color: theme.colorScheme.tertiary,
      ),
      label: const Text('3 days ago'),
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

    Widget child = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 36.0,
            decoration: ShapeDecoration(
              color: theme.colorScheme.secondaryContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
          gap4,
          timer,
          gap12,
          if (discount) ...[
            Center(
              child: Text(
                '\$$normalPrice',
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
      child = Stack(fit: StackFit.loose, children: [child, best]);
    }

    return TonalCard(
      elevation: isSelected ? 4.0 : 1.0,
      margin: emptyPadding,
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(
          theme.colorScheme.primary.withOpacity(0.08),
        ),
        onTap: () {},
        child: child,
      ),
    );
  }
}
