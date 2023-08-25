import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/thumb_image.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompactDeal extends ConsumerWidget {
  const CompactDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final theme = Theme.of(context);
    final PriceTheme priceTheme = theme.extension<PriceTheme>()!;
    final bool discount = deal.savings != 0;
    final textTheme = theme.textTheme;
    final Color discountColor = priceTheme.discountColor;
    final Color normalPriceColor = priceTheme.regularColor;
    Widget price;
    if (deal.savings == 100 || double.tryParse(deal.salePrice) == 0) {
      price = Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: ShapeDecoration(
          color: discountColor,
          shape: const StadiumBorder(),
        ),
        child: Center(
          child: Text(
            S.of(context).free,
            style: TextStyle(
              color: priceTheme.onDiscountColor,
              fontSize: 12.0,
              letterSpacing: -0.15,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      );
    } else {
      price = Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '\$${deal.salePrice}',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14.0,
            letterSpacing: -0.15,
            color: discount ? discountColor : null,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
      );
    }
    if (discount) {
      price = Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${deal.normalPrice}',
            style: textTheme.bodySmall?.copyWith(
              fontSize: 12.0,
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: normalPriceColor,
              decorationThickness: 1.0,
              color: normalPriceColor,
              height: 0.75,
            ),
            maxLines: 1,
          ),
          price,
        ],
      );
    }

    final lateralPrice = Container(
      constraints: BoxConstraints(minWidth: 168.0),
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: theme.colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(16.0),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          price,
          gap8,
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              height: 54.0,
              width: 80.0,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: ProviderScope(
                overrides: [
                  thumbProvider.overrideWith(
                    (ProviderRef ref) => ref.watch(singleDeal).thumb,
                  ),
                ],
                child: const ThumbImage(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final Widget child = Card(
      color: theme.colorScheme.background,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outline),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.all(8.0),
              child: _TitleDeal(),
            ),
          ),
          gap8,
          lateralPrice,
        ],
      ),
    );
    return InkWell(
      child: child,
    );
  }
}

class _TitleDeal extends ConsumerWidget {
  const _TitleDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);

    const subtitle = _Subtitle();

    if (deal.title.isEmpty) {
      return subtitle;
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 4.0, end: 4.0),
          child: Text(
            deal.title,
            maxLines: 2,
            style: const TextStyle(
              height: 1.15,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle,
      ],
    );
  }
}

class _Subtitle extends ConsumerWidget {
  const _Subtitle({Key? key})  : super(key: key);

  String _difference(S translate, int mEpoch) {
    final DateTime change = DateTime.fromMillisecondsSinceEpoch(mEpoch * 1000);
    final difference = DateTime.now().difference(change);
    if (difference.inDays >= 365)
      return translate.change_in_years(difference.inDays ~/ 365);
    else if (difference.inDays >= 30)
      return translate.change_in_months(difference.inDays ~/ 30);
    else if (difference.inHours >= 24)
      return translate.change_in_days(difference.inHours ~/ 24);
    else if (difference.inMinutes >= 60)
      return translate.change_in_hours(difference.inMinutes ~/ 60);
    else if (difference.inMinutes >= 1)
      return translate.change_in_minutes(difference.inMinutes);
    else
      return translate.now;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final theme = Theme.of(context);
    final deal = ref.watch(singleDeal);
    String time = _difference(translate, deal.lastChange);
    List<Widget> widgets = <Widget>[
      ProviderScope(
        overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
        child: StoreAvatarIcon(
          size: theme.textTheme.bodyMedium?.fontSize,
        ),
      ),
      gap8,
      Text(
        time,
        style: theme.textTheme.labelSmall,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: ShapeDecoration(
        color: theme.colorScheme.secondaryContainer,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}