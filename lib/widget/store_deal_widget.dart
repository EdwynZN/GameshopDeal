import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:gameshop_deals/riverpod/preference_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/widget/display_deal/price_widget.dart';
import 'package:gameshop_deals/widget/display_deal/store_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDealGrid extends ConsumerWidget {
  const StoreDealGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final deal = ref.watch(singleDeal);
    assert(deal != null);
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style.copyWith(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) return null;
              return Theme.of(context).cardColor;
            }),
          ),
      onPressed: () async {
        String _dealLink = '${cheapsharkUrl}/redirect?dealID=${deal.dealId}';
        if (await canLaunch(_dealLink)) {
          final bool webView = ref.read(preferenceProvider.state).webView;
          await launch(_dealLink,
              forceWebView: webView, enableJavaScript: webView);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error Launching url')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 56.0, maxHeight: 48),
                child: ProviderScope(
                  overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
                  child: const StoreAvatarBanner(),
                ),
              ),
            ),
            const PriceWidget(),
          ],
        ),
      ),
    );
  }
}

class StoreDealTile extends ConsumerWidget {
  const StoreDealTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      child: ListTile(
        onTap: () async {
          String _dealLink =
              'https://www.cheapshark.com/redirect?dealID=${deal.dealId}';
          if (await canLaunch(_dealLink)) {
            final bool webView = ref.read(preferenceProvider.state).webView;
            await launch(_dealLink,
                forceWebView: webView, enableJavaScript: webView);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error Launching url: $_dealLink')));
          }
        },
        title: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 56.0, maxHeight: 48),
          child: ProviderScope(
            overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
            child: const StoreAvatarBanner(
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        trailing: const PriceWidget(),
      ),
    );
  }
}
