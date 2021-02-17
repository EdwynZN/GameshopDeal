import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart'
    show singleGameLookup, gameKeysProvider;
import 'package:gameshop_deals/riverpod/preference_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/widget/display_deal/price_widget.dart';
import 'package:gameshop_deals/widget/display_deal/saved_deal_button.dart';
import 'package:gameshop_deals/widget/display_deal/store_avatar.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:gameshop_deals/widget/display_gamelookup/cheapest_ever.dart';
import 'package:url_launcher/url_launcher.dart';

final indexGameLookup = ScopedProvider<int>(null);

class DetailedGameLookup extends ConsumerWidget {
  const DetailedGameLookup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(singleGameLookup);
    assert(game != null);
    final int index = watch(indexGameLookup);
    final Widget child = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: const Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 8.0, bottom: 4, end: 4),
              child: const _TitleGameLookup(showCheapest: true),
            ),
          ),
          Flexible(
            flex: null,
            child: Center(
              child: ProviderScope(
                overrides: [
                  singleDeal.overrideAs(
                      (watch) => watch(singleGameLookup).deals.first)
                ],
                child: const PriceWidget(),
              ),
            ),
          ),
        ],
      ),
    );
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: index),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [
              singleGameLookup.overrideWithValue(game),
              indexGameLookup.overrideWithValue(index),
            ],
            child: const _BottomSheetButtonsGameLookup(),
          ),
        );
      },
      child: child,
    );
  }
}

class CompactGameLookup extends ConsumerWidget {
  const CompactGameLookup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(singleGameLookup);
    assert(game != null);
    final String title = game.info.title;
    final int index = watch(indexGameLookup);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: Divider.createBorderSide(context)),
      ),
      child: ListTile(
        leading: ProviderScope(
          overrides: [
            storeIdProvider.overrideWithValue(game.deals.first.storeId)
          ],
          child: const StoreAvatarIcon(),
        ),
        dense: true,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsetsDirectional.only(end: 4, top: 4),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (var deal in game.deals.skip(1))
                ProviderScope(
                  overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
                  child: StoreAvatarIcon(
                    size: Theme.of(context).textTheme.bodyText2.fontSize,
                  ),
                ),
            ],
          ),
        ),
        trailing: ProviderScope(
          overrides: [
            singleDeal
                .overrideAs((watch) => watch(singleGameLookup).deals.first)
          ],
          child: const PriceWidget(),
        ),
        onTap: () =>
            Navigator.of(context).pushNamed(detailRoute, arguments: index),
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (context) => ProviderScope(
              overrides: [
                singleGameLookup.overrideWithValue(game),
                indexGameLookup.overrideWithValue(index),
              ],
              child: const _BottomSheetButtonsGameLookup(),
            ),
          );
        },
      ),
    );
  }
}

class GridGameLookup extends ConsumerWidget {
  const GridGameLookup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final game = watch(singleGameLookup);
    assert(game != null);
    final int index = watch(indexGameLookup);
    final color = Colors.grey[850];
    final theme = Theme.of(context);
    final Color borderColor = theme.brightness == Brightness.light
        ? Colors.black38
        : theme.dividerColor;
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: index),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [
              singleGameLookup.overrideWithValue(game),
              indexGameLookup.overrideWithValue(index),
            ],
            child: const _BottomSheetButtonsGameLookup(),
          ),
        );
      },
      child: GridTile(
        header: GridTileBar(
          title: Text(
            game.info.title,
            maxLines: 2,
          ),
          leading: ProviderScope(
            overrides: [
              storeIdProvider.overrideWithValue(game.deals.first.storeId)
            ],
            child: StoreAvatarIcon(
              size: Theme.of(context).textTheme.bodyText2.fontSize,
            ),
          ),
        ),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              tileMode: TileMode.mirror,
              colors: <Color>[
                color,
                color.withOpacity(0.75),
                color.withOpacity(0.0),
              ],
              stops: [0.0, 0.3, 0.5],
            ),
          ),
          child: ProviderScope(
            overrides: [
              thumbProvider
                  .overrideAs((watch) => watch(singleGameLookup).info.thumb)
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
            fit: BoxFit.scaleDown,
            child: ProviderScope(
              overrides: [
                singleDeal
                    .overrideAs((watch) => watch(singleGameLookup).deals.first)
              ],
              child: const PriceWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class ListGameLookup extends StatelessWidget {
  const ListGameLookup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget child = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 70, maxWidth: 120),
                  child: ProviderScope(
                    overrides: [
                      thumbProvider.overrideAs(
                          (watch) => watch(singleGameLookup).info.thumb)
                    ],
                    child: const ThumbImage(),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4),
              child: const _TitleGameLookup(),
            ),
          ),
          Flexible(
            flex: null,
            child: ProviderScope(
              overrides: [
                singleDeal
                    .overrideAs((watch) => watch(singleGameLookup).deals.first)
              ],
              child: const PriceWidget(),
            ),
          ),
        ],
      ),
    );
    return Consumer(
      child: child,
      builder: (context, watch, child) {
        final game = watch(singleGameLookup);
        final int index = watch(indexGameLookup);
        return InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(detailRoute, arguments: index),
          onLongPress: () async {
            showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (context) => ProviderScope(
                overrides: [
                singleGameLookup.overrideWithValue(game),
                indexGameLookup.overrideWithValue(index),
              ],
                child: const _BottomSheetButtonsGameLookup(),
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}

class _TitleGameLookup extends ConsumerWidget {
  final bool showCheapest;
  const _TitleGameLookup({Key key, this.showCheapest = false})
      : assert(showCheapest != null),
        super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(singleGameLookup);
    assert(game != null);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (game.info.title.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 4, end: 4),
            child: Text(
              game.info.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (showCheapest)
          const Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 4, end: 4),
            child: CheapestEverWidget(),
          ),
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 4),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (var deal in game.deals)
                ProviderScope(
                  overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
                  child: StoreAvatarIcon(
                    size: Theme.of(context).textTheme.bodyText2.fontSize,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomSheetButtonsGameLookup extends ConsumerWidget {
  const _BottomSheetButtonsGameLookup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final game = watch(singleGameLookup);
    assert(game != null, 'GameLookup cannot be null');
    final title = game.info.title;
    return SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border(bottom: Divider.createBorderSide(context))),
              child: Text.rich(
                TextSpan(
                  text: '$title\n',
                  children: [
                    const WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: CheapestEverWidget(),
                      ),
                    ),
                  ]
                ),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ProviderScope(
            overrides: [
              singleDeal.overrideAs((watch) {
                final index = watch(indexGameLookup);
                final keys = watch(gameKeysProvider);
                return game.deals.first.copyWith(gameId: keys[index], title: game.info.title);
              }),
            ], 
            child: const SavedTextDealButton(),
          ),
          Wrap(
            spacing: 8.0,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              for (var deal in game.deals)
                TextButton.icon(
                  icon: ProviderScope(
                    overrides: [
                      storeIdProvider.overrideWithValue(deal.storeId)
                    ],
                    child: StoreAvatarIcon(
                      size: IconTheme.of(context).size / 1.2,
                    ),
                  ),
                  label: Text('\$${deal.salePrice}'),
                  onPressed: () async {
                    String _gameLookupLink =
                        '${cheapsharkUrl}/redirect?dealID=${deal.dealId}';
                    if (await canLaunch(_gameLookupLink)) {
                      final bool webView =
                          context.read(preferenceProvider.state).webView;
                      await launch(_gameLookupLink,
                          forceWebView: webView, enableJavaScript: webView);
                    }
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
