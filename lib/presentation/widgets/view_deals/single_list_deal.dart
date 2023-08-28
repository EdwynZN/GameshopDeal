import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/presentation/widgets/material_card.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/save_button.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/thumb_image.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/preference_provider.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

final _indexDeal = Provider.autoDispose<int>((_) => throw UnimplementedError());

class SliverListDeal extends HookWidget {
  final List<Deal> deals;

  const SliverListDeal({super.key, required this.deals});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            return ProviderScope(
              overrides: [
                _indexDeal.overrideWithValue(index),
                singleDeal.overrideWithValue(deals[itemIndex])
              ],
              child: ListDealUI(),
            );
          }
          return Divider(
            height: 1,
            thickness: 1,
            endIndent: 0,
            indent: 0,
            color: Theme.of(context).colorScheme.outline,
          );
        },
        childCount: math.max(0, deals.length * 2 - 1),
        semanticIndexCallback: (Widget widget, int index) {
          return index.isEven ? index ~/ 2 : null;
        },
      ),
    );
  }
}

/// New ListDeal UI

class ListDealUI extends HookConsumerWidget {
  const ListDealUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    final DateTime? dateTime = useMemoized(
      () => deal.releaseDate == 0
          ? null
          : DateTime.fromMillisecondsSinceEpoch(deal.releaseDate * 1000),
      [deal.releaseDate],
    );
    final lastChange = useMemoized(() {
      final lastChange =
          DateTime.fromMillisecondsSinceEpoch(deal.lastChange * 1000);
      final difference = DateTime.now().difference(lastChange);
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
    }, [translate, deal.lastChange]);

    final Widget body = Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: _InfoBody(
        title: deal.title,
        releaseDate: dateTime,
        lastChange: deal.lastChange,
        normalPrice: deal.normalPrice,
        salePrice: deal.salePrice,
        savings: deal.savings,
        metacriticScore: int.tryParse(deal.metacriticScore),
      ),
    );
    final Widget row = Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: _BottomRowInfo(
        lastChange: lastChange,
        storeId: deal.storeId,
      ),
    );
    return Material(
      type: MaterialType.canvas,
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: () {
          context.pushNamed(
            detailName,
            pathParameters: {
              'id': deal.gameId,
            },
          );
        },
        child: Column(
          children: [body, gap12, row],
        ),
      ),
    );
  }
}

class _InfoBody extends StatelessWidget {
  final String title;
  final DateTime? releaseDate;
  final int? savings;
  final int lastChange;
  final String normalPrice;
  final String salePrice;
  final int? metacriticScore;

  const _InfoBody({
    // ignore: unused_element
    super.key,
    required this.title,
    required this.releaseDate,
    required this.lastChange,
    required this.salePrice,
    required this.normalPrice,
    required this.metacriticScore,
    this.savings,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final insideBody = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.10,
              height: 0,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          if (releaseDate != null) ...[
            gap4,
            Text(
              MaterialLocalizations.of(context).formatShortDate(releaseDate!),
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.0,
                height: 0,
              ),
            ),
          ],
        ],
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        insideBody,
        gap12,
        SizedBox(
          width: 120.0,
          child: _LateralAssetPrice(
            lastChange: lastChange,
            normalPrice: normalPrice,
            salePrice: salePrice,
            savings: savings,
            metacriticScore: metacriticScore,
          ),
        ),
      ],
    );
  }
}

class _BottomRowInfo extends StatelessWidget {
  final String lastChange;
  final String storeId;

  const _BottomRowInfo({
    // ignore: unused_element
    super.key,
    required this.lastChange,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chip = Chip(
      avatar: CircleAvatar(
        maxRadius: 8.0,
        child: ProviderScope(
          overrides: [storeIdProvider.overrideWithValue(storeId)],
          child: const StoreAvatarIcon(size: 16.0),
        ),
      ),
      label: Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: '· ', style: TextStyle(letterSpacing: 0.5)),
            TextSpan(text: lastChange),
          ],
        ),
      ),
      shape: const StadiumBorder(),
      surfaceTintColor: theme.colorScheme.tertiary,
      labelPadding: const EdgeInsetsDirectional.only(start: 4.0),
      elevation: 4.0,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      side: BorderSide.none,
      labelStyle: TextStyle(
        letterSpacing: 0.10,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.onTertiaryContainer,
        overflow: TextOverflow.clip,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shadowColor: Colors.transparent,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        chip,
        const Spacer(),
        gap16,
        IconButton(
          tooltip: 'Save game',
          icon: const Icon(Icons.bookmark_outline_outlined),
          onPressed: () {},
        ),
        IconButton.filledTonal(
          tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
          icon: const Icon(Icons.more_vert_outlined),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _LateralAssetPrice extends HookWidget {
  final int? savings;
  final int lastChange;
  final String normalPrice;
  final String salePrice;
  final int? metacriticScore;

  const _LateralAssetPrice({
    // ignore: unused_element
    super.key,
    required this.lastChange,
    required this.salePrice,
    required this.normalPrice,
    this.metacriticScore,
    this.savings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PriceTheme priceTheme = theme.extension<PriceTheme>()!;
    final bool discount = savings != 0;
    final textTheme = theme.textTheme;
    final Color discountColor = priceTheme.discountColor;
    final Color normalPriceColor = priceTheme.regularColor;
    final Widget price;
    if (savings == 100 || double.tryParse(salePrice) == 0) {
      price = Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
        decoration: ShapeDecoration(
          color: discountColor,
          shape: const StadiumBorder(),
        ),
        child: Text(
          S.of(context).free,
          style: TextStyle(
            color: priceTheme.onDiscountColor,
            fontSize: 16.0,
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
          fontSize: 16.0,
          letterSpacing: -0.15,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AssetDeal(metacriticScore: metacriticScore),
        gap8,
        if (discount) ...[
          Center(
            child: Text(
              '\$$normalPrice',
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 14.0,
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
          gap4,
        ],
        price,
      ],
    );
  }
}

class _AssetDeal extends StatelessWidget {
  final num? metacriticScore;

  // ignore: unused_element
  const _AssetDeal({super.key, this.metacriticScore});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final Widget child;

    final asset = ProviderScope(
      overrides: [
        thumbProvider.overrideWith(
          (ProviderRef ref) => ref.watch(singleDeal).thumb,
        ),
      ],
      child: const ThumbImage(
        alignment: Alignment.topCenter,
        fit: BoxFit.cover,
      ),
    );
    if (metacriticScore == null || metacriticScore == 0) {
      child = asset;
    } else {
      final chip = Chip(
        avatar: Image(
          image: const AssetImage('assets/thumbnails/metacritic.png'),
          fit: BoxFit.scaleDown,
          height: 12.0,
          width: 12.0,
        ),
        label: Text(
          '$metacriticScore%',
          maxLines: 1,
          overflow: TextOverflow.clip,
        ),
        shape: const StadiumBorder(),
        surfaceTintColor: theme.tertiary,
        labelPadding: const EdgeInsetsDirectional.only(start: 4.0),
        visualDensity: const VisualDensity(vertical: -3.0, horizontal: -2.0),
        elevation: 8.0,
        side: BorderSide.none,
        labelStyle: TextStyle(
          fontSize: 11.0,
          color: theme.onTertiaryContainer,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shadowColor: Colors.transparent,
      );
      child = Stack(
        fit: StackFit.passthrough,
        children: [
          asset,
          Positioned(
            right: 4.0,
            top: 4.0,
            child: chip,
          )
        ],
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        height: 70.0,
        width: 120.0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ColoredBox(
          color: ElevationOverlay.applySurfaceTint(
            theme.background,
            theme.tertiary,
            2.0,
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Old ListDeal UI

class ListDeal extends HookConsumerWidget {
  final ValueNotifier<int?> action;

  const ListDeal({super.key, required this.action});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int index = ref.watch(_indexDeal);
    final isActive = useListenableSelector(action, () => index == action.value);
    final deal = ref.watch(singleDeal);

    final left = _LateralPriceDetail(
      lastChange: deal.lastChange,
      normalPrice: deal.normalPrice,
      salePrice: deal.salePrice,
      savings: deal.savings,
    );
    final right = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _InfoDeal(
                  title: deal.title,
                  releaseDate: deal.releaseDate,
                  metacriticScore: deal.metacriticScore,
                  publisher: deal.publisher,
                  steamRating: deal.steamRatingText == null
                      ? null
                      : (
                          ratingText: deal.steamRatingText!,
                          percent: deal.steamRatingPercent,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ProviderScope(
                  overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
                  child: const StoreAvatarLogo(size: 32.0),
                ),
              ),
            ],
          ),
          gap8,
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSize(
              alignment: Alignment.bottomCenter,
              duration: const Duration(milliseconds: 350),
              reverseDuration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubicEmphasized,
              child: isActive ? _ActionRow(deal: deal) : emptyWidget,
            ),
          ),
        ],
      ),
    );

    final Widget child = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          left,
          Expanded(child: right),
        ],
      ),
    );

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: TonalCard(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        elevation: 4.0,
        child: InkWell(
          onTap: () => action.value = action.value == index ? null : index,
          child: child,
        ),
      ),
    );
  }
}

class _LateralPriceDetail extends HookWidget {
  final int? savings;
  final int lastChange;
  final String normalPrice;
  final String salePrice;
  const _LateralPriceDetail({
    // ignore: unused_element
    super.key,
    required this.lastChange,
    required this.salePrice,
    required this.normalPrice,
    this.savings,
  });

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    final theme = Theme.of(context);
    final PriceTheme priceTheme = theme.extension<PriceTheme>()!;
    final bool discount = savings != 0;
    final textTheme = theme.textTheme;
    final Color discountColor = priceTheme.discountColor;
    final Color normalPriceColor = priceTheme.regularColor;
    final Widget price;
    if (savings == 100 || double.tryParse(salePrice) == 0) {
      price = Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: ShapeDecoration(
          color: discountColor,
          shape: const StadiumBorder(),
        ),
        child: Center(
          child: Text(
            S.of(context).free,
            style: TextStyle(
              color: priceTheme.onDiscountColor,
              fontSize: 16.0,
              letterSpacing: 0.15,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      );
    } else {
      price = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Center(
          child: Text(
            '\$$salePrice',
            style: textTheme.titleLarge?.copyWith(
              color: discount ? discountColor : null,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      );
    }

    final time = useMemoized(() {
      final DateTime change =
          DateTime.fromMillisecondsSinceEpoch(lastChange * 1000);
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
    }, [translate, lastChange]);
    final Widget timeLabel = Container(
      padding: allPadding8,
      decoration: ShapeDecoration(
        color: theme.colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12.0),
            topLeft: Radius.circular(12.0),
          ),
        ),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Icon(
                Icons.timelapse,
                size: 14.0,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            TextSpan(text: ' $time'),
          ],
        ),
        style: TextStyle(
          letterSpacing: 0.10,
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: theme.colorScheme.onPrimary,
          overflow: TextOverflow.clip,
        ),
      ),
    );

    return ColoredBox(
      color: theme.colorScheme.surfaceVariant,
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightForFinite(width: 120.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            timeLabel,
            gap8,
            Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  height: 70.0,
                  width: 96.0,
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
                      alignment: Alignment.topCenter,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            gap12,
            //const Spacer(),
            if (discount)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    '\$$normalPrice',
                    style: textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: normalPriceColor,
                      decorationThickness: 1.0,
                      color: normalPriceColor,
                      height: 0.75,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            price,
            gap8,
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final Deal deal;
  // ignore: unused_element
  const _ActionRow({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Wrap(
          alignment: WrapAlignment.end,
          direction: Axis.horizontal,
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            const SavedTextDealButton(),
            IconButton.filledTonal(
              onPressed: () {},
              tooltip: 'Share',
              icon: const Icon(Icons.share),
            ),
            IconButton.filledTonal(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => ProviderScope(
                    overrides: [singleDeal.overrideWithValue(deal)],
                    child: const _BottomSheetButtonsDeal(),
                  ),
                );
              },
              tooltip: 'More',
              icon: const Icon(Icons.read_more_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoDeal extends StatelessWidget {
  final String title;
  final int releaseDate;
  final String metacriticScore;
  final ({String ratingText, String percent})? steamRating;
  final String? publisher;

  const _InfoDeal({
    // ignore: unused_element
    super.key,
    required this.releaseDate,
    required this.title,
    required this.metacriticScore,
    required this.steamRating,
    this.publisher,
  });

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    final theme = Theme.of(context);
    List<InlineSpan> span = <InlineSpan>[];
    if (metacriticScore != '0') {
      final int? metaScore = int.tryParse(metacriticScore);
      if (metaScore != null) {
        span.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CircleAvatar(
                  radius: 6,
                  backgroundImage:
                      AssetImage('assets/thumbnails/metacritic.png'),
                ),
                Text(
                  ' ${metaScore}%',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
        );
      }
    }
    final ({String percent, String ratingText})? _rating = steamRating;
    if (_rating != null) {
      Color color, textColor = Colors.white;
      final int rating = int.parse(_rating.percent);
      final String ratingText = _rating.ratingText.replaceAll(' ', '_');
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
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            decoration: ShapeDecoration(
              color: color,
              shape: const StadiumBorder(),
            ),
            child: Text(
              translate.review(ratingText),
              style: theme.textTheme.labelSmall?.copyWith(color: textColor),
            ),
          ),
        ),
      );
    }
    if (publisher != null) {
      span.add(
        TextSpan(
          text: publisher,
          style: theme.primaryTextTheme.labelSmall?.copyWith(
            height: 1.5,
            backgroundColor: theme.colorScheme.secondary,
          ),
        ),
      );
    }

    for (int i = 1; i < span.length; i = i + 2) {
      span.insert(i, const TextSpan(text: ' · '));
    }

    final subtitle = RichText(
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      text: TextSpan(
        style: theme.textTheme.labelMedium,
        children: span,
      ),
    );

    Widget? releaseDateWidget;
    if (releaseDate != 0) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
      final formatShortDate =
          MaterialLocalizations.of(context).formatShortDate(dateTime);
      releaseDateWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          formatShortDate,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(height: 1.75),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.start,
          style: const TextStyle(
            height: 1.35,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.25,
            wordSpacing: -0.25,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        if (releaseDateWidget != null) releaseDateWidget,
        subtitle,
      ],
    );
  }
}

class _BottomSheetButtonsDeal extends ConsumerWidget {
  const _BottomSheetButtonsDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    final title = deal.title;
    final metacriticLink = deal.metacriticLink;
    final steamAppId = deal.steamAppId;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      constraints: BoxConstraints(minWidth: 320.0, maxWidth: 380.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(bottom: Divider.createBorderSide(context)),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
            ),
          TextButton.icon(
            style: ButtonStyle(
                iconSize: const MaterialStatePropertyAll(36.0),
                textStyle:
                    MaterialStatePropertyAll(theme.textTheme.headlineSmall)),
            icon: ProviderScope(
              overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
              child: StoreAvatarLogo(),
            ),
            label: Text(translate.go_to_deal),
            onPressed: () async {
              final _dealLink =
                  Uri.parse('${cheapsharkUrl}/redirect?dealID=${deal.dealId}');
              if (await canLaunchUrl(_dealLink)) {
                final bool webView = ref.read(preferenceProvider).webView;
                await launchUrl(
                  _dealLink,
                  mode: webView
                      ? LaunchMode.externalApplication
                      : LaunchMode.inAppWebView,
                );
              }
            },
          ),
          if (steamAppId != null) ...[
            TextButton.icon(
              icon: const Icon(Icons.rate_review),
              label: Text(translate.review_tooltip),
              onPressed: () async {
                final Uri _steamLink = Uri.https(
                  steamUrl,
                  '/app/${deal.steamAppId}',
                );
                if (await canLaunchUrl(_steamLink)) {
                  final bool webView = ref.read(preferenceProvider).webView;
                  await launchUrl(
                    _steamLink,
                    mode: webView
                        ? LaunchMode.externalApplication
                        : LaunchMode.inAppWebView,
                  );
                }
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.computer),
              label: const Text('PC Wiki'),
              onPressed: () async {
                final Uri _pcGamingWikiUri = Uri.https(
                    pcWikiUrl, '/api/appid.php', {'appid': steamAppId});
                if (await canLaunchUrl(_pcGamingWikiUri)) {
                  final bool webView = ref.read(preferenceProvider).webView;
                  await launchUrl(
                    _pcGamingWikiUri,
                    mode: webView
                        ? LaunchMode.externalApplication
                        : LaunchMode.inAppWebView,
                  );
                }
              },
            ),
          ],
          if (metacriticLink != null)
            TextButton.icon(
              icon: CircleAvatar(
                radius: (IconTheme.of(context).size ?? 24.0) / 2.4,
                backgroundImage:
                    const AssetImage('assets/thumbnails/metacritic.png'),
              ),
              label: const Text('Metacritic'),
              onPressed: () async {
                final Uri _metacriticLink = Uri.https(
                  metacriticUrl,
                  metacriticLink,
                );
                if (await canLaunchUrl(_metacriticLink)) {
                  final bool webView = ref.read(preferenceProvider).webView;
                  await launchUrl(
                    _metacriticLink,
                    mode: webView
                        ? LaunchMode.externalApplication
                        : LaunchMode.inAppWebView,
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
