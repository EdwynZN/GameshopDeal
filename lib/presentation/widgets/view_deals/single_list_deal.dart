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
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

final _indexDeal = Provider.autoDispose<int>((_) => throw UnimplementedError());

class SliverListDeal extends HookWidget {
  final List<Deal> deals;

  const SliverListDeal({super.key, required this.deals});

  @override
  Widget build(BuildContext context) {
    final actionIndex = useValueNotifier<int?>(null, const []);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext _, int index) {
          return ProviderScope(
            overrides: [
              _indexDeal.overrideWithValue(index),
              singleDeal.overrideWithValue(deals[index])
            ],
            child: ListDeal(action: actionIndex),
          );
        },
        childCount: deals.length,
      ),
    );
  }
}

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
      constraints: const BoxConstraints(maxWidth: 800.0),
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
    final bool discount = savings != 0;
    final textTheme = theme.textTheme;
    final brightness = ThemeData.estimateBrightnessForColor(
      theme.scaffoldBackgroundColor,
    );
    final Color discountColor = brightness == Brightness.light
        ? Colors.green.shade700
        : Colors.greenAccent;
    final Color normalPriceColor =
        brightness == Brightness.light ? Colors.grey.shade700 : Colors.orange;
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
            style: const TextStyle(
              color: Colors.white,
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
            const Spacer(),
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
