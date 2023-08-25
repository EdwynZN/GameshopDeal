import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/metacritic.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/thumb_image.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailedDeal extends ConsumerWidget {
  const DetailedDeal({Key? key}) : super(key: key);

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
      ),
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 8.0,
                top: 4.0,
                bottom: 4.0,
                end: 4.0,
              ),
              child: const _TitleDeal(),
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

    const subtitle = Padding(
      padding: EdgeInsetsDirectional.only(end: 4),
      child: _Subtitle(),
    );

    if (deal.title.isEmpty) {
      return subtitle;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 4.0, end: 4.0),
          child: Text(
            deal.title,
            maxLines: 2,
            style: const TextStyle(
              height: 1.25,
              fontSize: 16.0,
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
  final bool showStore;
  final bool showMetacritic;
  final bool showReleaseDate;
  final bool showRating;
  final bool showLastChange;

  const _Subtitle({
    Key? key,
    bool? showStore,
    bool? showMetacritic,
    bool? showReleaseDate,
    bool? showRating,
    bool? showLastChange,
  })  : this.showStore = showStore ?? true,
        this.showMetacritic = showMetacritic ?? true,
        this.showReleaseDate = showReleaseDate ?? true,
        this.showRating = showRating ?? true,
        this.showLastChange = showLastChange ?? true,
        super(key: key);

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
    List<InlineSpan> span = <InlineSpan>[
      if (showStore)
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: ProviderScope(
            overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
            child: StoreAvatarIcon(
              size: theme.textTheme.bodyMedium?.fontSize,
            ),
          ),
        ),
    ];
    if (showMetacritic && deal.metacriticScore != '0') {
      span.add(
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Metacritic(),
        ),
      );
    }
    if (showRating && deal.steamRatingText != null) {
      Color color, textColor = Colors.white;
      final int rating = int.parse(deal.steamRatingPercent);
      final String ratingText = deal.steamRatingText!.replaceAll(' ', '_');
      if (rating >= 95) {
        color = Colors.green.shade300;
        textColor = Colors.black;
      } else if (rating >= 65) {
        color = Colors.lightGreen.shade300;
        textColor = Colors.black;
      } else if (rating >= 40) {
        color = Colors.orange;
        textColor = Colors.black;
      } else {
        color = Colors.red.shade600;
      }
      span.add(
        TextSpan(
          text: ' ${translate.review(ratingText)} ',
          style: theme.textTheme.labelSmall?.copyWith(
            backgroundColor: color,
            color: textColor,
          ),
        ),
      );
    }
    if (deal.publisher != null) {
      span.add(
        TextSpan(
          text: deal.publisher,
          style: theme.primaryTextTheme.labelSmall?.copyWith(
            height: 1.5,
            backgroundColor: theme.colorScheme.secondary,
          ),
        ),
      );
    }
    if (showLastChange) {
      String time = _difference(translate, deal.lastChange);
      span.add(
        TextSpan(text: time),
      );
    }

    for (int i = 1; i < span.length; i = i + 2) {
      span.insert(i, const TextSpan(text: ' · '));
    }

    final int releaseDate = deal.releaseDate;
    if (showReleaseDate && releaseDate != 0) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
      final formatShortDate =
          MaterialLocalizations.of(context).formatShortDate(dateTime);
      final bool alreadyRealeased = DateTime.now().isAfter(dateTime);
      final String time = alreadyRealeased
          ? translate.release(formatShortDate)
          : ' ${translate.future_release(formatShortDate)} ';
      span.insert(
        0,
        TextSpan(
          text: '$time\n',
          style: alreadyRealeased
              ? theme.textTheme.labelSmall?.copyWith(height: 1.75)
              : theme.textTheme.labelSmall?.copyWith(
                  color: Colors.black,
                  height: 1.75,
                  backgroundColor: Colors.orangeAccent,
                ),
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      text: TextSpan(
        style: theme.textTheme.labelSmall,
        children: span,
      ),
    );
  }
}