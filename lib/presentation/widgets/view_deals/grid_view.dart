import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/thumb_image.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/preference_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/utils/theme_constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class VerticalGridDeal extends ConsumerWidget {
  const VerticalGridDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final theme = Theme.of(context);
    final color = theme.colorScheme.surfaceVariant;
    final PriceTheme priceTheme = theme.extension<PriceTheme>()!;
    final bool discount = deal.savings != 0;
    final textTheme = theme.textTheme;
    final Color discountColor = priceTheme.discountColor;
    final Color normalPriceColor = priceTheme.regularColor;
    final Widget price;
    if (deal.savings == 100 || double.tryParse(deal.salePrice) == 0) {
      price = Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text(
            '\$${deal.salePrice}',
            style: textTheme.titleLarge?.copyWith(
              color: discount ? discountColor : null,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      );
    }

    final footer = Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (discount)
          Center(
            child: Text(
              '\$${deal.normalPrice}',
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
        price,
      ],
    );

    return InkWell(
      overlayColor: MaterialStatePropertyAll(
        theme.colorScheme.primaryContainer.withOpacity(0.24),
      ),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [singleDeal.overrideWithValue(deal)],
            child: const _BottomSheetButtonsDeal(),
          ),
        );
      },
      child: GridTile(
        header: GridTileBar(
          title: Text(
            deal.title,
            maxLines: 2,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          leading: ProviderScope(
            overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
            child: StoreAvatarIcon(
              size: Theme.of(context).textTheme.bodyMedium?.fontSize,
            ),
          ),
        ),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              side: BorderSide(color: theme.colorScheme.outline),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              tileMode: TileMode.mirror,
              colors: <Color>[
                color,
                color.withOpacity(0.84),
                color.withOpacity(0.0),
              ],
              stops: [0.0, 0.25, 0.5],
            ),
          ),
          child: ProviderScope(
            overrides: [
              thumbProvider.overrideWithValue(deal.thumb),
            ],
            child: const ThumbImage(
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              addInk: true,
            ),
          ),
        ),
        footer: GridTileBar(
          title: FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            child: footer,
          ),
        ),
      ),
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
